import prisma from '../../prisma';
import { AuthRequest } from '../../types/auth-request';
import { HttpError } from '../../types/error';
import {
    UpdateProfileInput,
    UpdateNotificationPreferenceInput,
    AddressInput,
    CardInput
} from '../../types/graphql-inputs';
const validator = require('validator');

function checkAuth(req: any) {
    if (!req.isAuth) {
        const err: HttpError = new Error('Not authorized');
        err.statusCode = 401;
        throw err;
    }
}

export default {
    me: async function (args: any, req: AuthRequest) {
        checkAuth(req);
        const user = await prisma.user.findUnique({
            where: { id: req.id! }
        });
        if (!user) {
            const err: HttpError = new Error('User does not exist');
            err.statusCode = 404;
            throw err;
        }
        return {
            ...user,
            notification_preference: () => prisma.notification_preference.findUnique({ where: { user_id: req.id! } }),
            address: () => prisma.address.findMany({ where: { user_id: req.id! } }),
            credit_card: () => prisma.credit_card.findMany({ where: { user_id: req.id! } }),
            order: () => prisma.order.findMany({ where: { user_id: req.id! } }),
            transaction: () => prisma.transaction.findMany({ where: { user_id: req.id! } }),
            favorite: () => prisma.product.findMany({ where: { favorite: { some: { user_id: req.id! } } } })
        };
    },

    updateProfile: async function ({ input }: { input: UpdateProfileInput }, req: AuthRequest) {
        checkAuth(req);
        if (input.name !== undefined) {
            input.name = input.name.trim();
            if (validator.isEmpty(input.name)) {
                const err: HttpError = new Error('Name cannot be empty');
                err.statusCode = 422;
                throw err;
            }
        }
        if (input.phone !== undefined) {
            input.phone = input.phone.trim();
        }
        if (input.email !== undefined) {
            input.email = input.email.trim().toLowerCase();
            if (!validator.isEmail(input.email)) {
                const err: HttpError = new Error('Invalid email');
                err.statusCode = 422;
                throw err;
            }
            const existingUser = await prisma.user.findFirst({
                where: { email: input.email, NOT: { id: req.id! } }
            });
            if (existingUser) {
                const err: HttpError = new Error('Email already in use');
                err.statusCode = 422;
                throw err;
            }
        }
        return await prisma.user.update({
            where: { id: req.id! },
            data: input,
            include: {
                notification_preference: true,
                address: true,
                credit_card: true,
                order: true,
                transaction: true,
                favorite: true
            }
        });
    },

    updateNotificationPreference: async function (args: UpdateNotificationPreferenceInput, req: AuthRequest) {
        checkAuth(req);
        return await prisma.notification_preference.update({
            where: { user_id: req.id! },
            data: args
        });
    },

    addAddress: async function ({ input }: { input: AddressInput }, req: AuthRequest) {
        checkAuth(req);
        const { is_default, ...addressData } = input;
        const newAddress = await prisma.address.create({
            data: {
                user_id: req.id!,
                ...addressData
            }
        });
        if (is_default) {
            await prisma.user.update({
                where: { id: req.id! },
                data: { default_address_id: newAddress.id }
            });
        }
        return newAddress;
    },

    updateAddress: async function ({ id, input }: { id: string; input: AddressInput }, req: AuthRequest) {
        checkAuth(req);
        const { is_default, ...addressData } = input;
        const updated = await prisma.address.update({
            where: { id: +id },
            data: addressData
        });
        if (is_default) {
            await prisma.user.update({
                where: { id: req.id! },
                data: { default_address_id: +id }
            });
        }
        return updated;
    },

    deleteAddress: async function ({ id }: { id: string }, req: AuthRequest) {
        checkAuth(req);
        await prisma.address.delete({ where: { id: +id } });
        return true;
    },

    setDefaultAddress: async function ({ id }: { id: string }, req: AuthRequest) {
        checkAuth(req);
        await prisma.user.update({
            where: { id: req.id! },
            data: { default_address_id: +id }
        });
        const addr = await prisma.address.findUnique({ where: { id: +id } });
        if (!addr) {
            const err: HttpError = new Error('Address not found');
            err.statusCode = 404;
            throw err;
        }
        return addr;
    },

    addCard: async function ({ input }: { input: CardInput }, req: AuthRequest) {
        checkAuth(req);
        const { is_default, card_number, last4, stripe_payment_id, ...cardData } = input as any;
        const finalLast4 = last4 || (card_number ? card_number.replaceAll(' ', '').slice(-4) : '1234');
        const newCard = await prisma.credit_card.create({
            data: {
                user_id: req.id!,
                last4: finalLast4,
                stripe_payment_id: stripe_payment_id || 'pm_mock_12345',
                ...cardData
            }
        });
        if (is_default) {
            await prisma.user.update({
                where: { id: req.id! },
                data: { default_credit_card_id: newCard.id }
            });
        }
        return newCard;
    },

    updateCreditCard: async function ({ id, input }: { id: string; input: CardInput }, req: AuthRequest) {
        checkAuth(req);
        const { is_default, card_number, last4, stripe_payment_id, cvv, ...cardData } = input as any;
        const updateData: any = { ...cardData };
        if (last4) updateData.last4 = last4;
        if (stripe_payment_id) updateData.stripe_payment_id = stripe_payment_id;

        const updated = await prisma.credit_card.update({
            where: { id: +id },
            data: updateData
        });
        if (is_default) {
            await prisma.user.update({
                where: { id: req.id! },
                data: { default_credit_card_id: +id }
            });
        }
        return updated;
    },

    deleteCard: async function ({ id }: { id: string }, req: AuthRequest) {
        checkAuth(req);
        await prisma.credit_card.delete({ where: { id: +id } });
        return true;
    },

    setDefaultCard: async function ({ id }: { id: string }, req: AuthRequest) {
        checkAuth(req);
        await prisma.user.update({
            where: { id: req.id! },
            data: { default_credit_card_id: +id }
        });
        const card = await prisma.credit_card.findUnique({ where: { id: +id } });
        if (!card) {
            const err: HttpError = new Error('Card not found');
            err.statusCode = 404;
            throw err;
        }
        return card;
    },

    setDefaultCreditCard: async function ({ id }: { id: string }, req: AuthRequest) {
        checkAuth(req);
        await prisma.user.update({
            where: { id: req.id! },
            data: { default_credit_card_id: +id }
        });
        const card = await prisma.credit_card.findUnique({ where: { id: +id } });
        if (!card) {
            const err: HttpError = new Error('Card not found');
            err.statusCode = 404;
            throw err;
        }
        return card;
    }
};
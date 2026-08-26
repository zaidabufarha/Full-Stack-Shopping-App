import prisma from '../../prisma';
import { AuthRequest } from '../../types/auth-request';
import { HttpError } from '../../types/error';

function checkAuth(req: any) {
    if (!req.isAuth) {
        const err: HttpError = new Error('Not authorized');
        err.statusCode = 401;
        throw err;
    }
}

export default {
    cart: async function (args: any, req: AuthRequest) {
        checkAuth(req);
        return await prisma.cart_item.findMany({
            where: { user_id: req.id! },
            include: { product: true }
        });
    },

    addToCart: async function ({ product_id, quantity }: { product_id: string; quantity: number }, req: AuthRequest) {
        checkAuth(req);
        return await prisma.cart_item.upsert({
            where: {
                user_id_product_id: {
                    user_id: req.id!,
                    product_id: +product_id
                }
            },
            update: {
                quantity: { increment: quantity }
            },
            create: {
                user_id: req.id!,
                product_id: +product_id,
                quantity
            },
            include: { product: true }
        });
    },

    updateCartItem: async function ({ cart_item_id, quantity }: { cart_item_id: string; quantity: number }, req: AuthRequest) {
        checkAuth(req);
        const item = await prisma.cart_item.findUnique({ where: { id: +cart_item_id } });
        if (!item) {
            const err: HttpError = new Error('Cart item not found');
            err.statusCode = 404;
            throw err;
        }
        if (item.user_id !== req.id!) {
            const err: HttpError = new Error('Not authorized');
            err.statusCode = 401;
            throw err;
        }
        return await prisma.cart_item.update({
            where: { id: +cart_item_id },
            data: { quantity },
            include: { product: true }
        });
    },

    removeFromCart: async function ({ cart_item_id }: { cart_item_id: string }, req: AuthRequest) {
        checkAuth(req);
        const item = await prisma.cart_item.findUnique({ where: { id: +cart_item_id } });
        if (!item) {
            const err: HttpError = new Error('Cart item not found');
            err.statusCode = 404;
            throw err;
        }
        if (item.user_id !== req.id!) {
            const err: HttpError = new Error('Not authorized');
            err.statusCode = 401;
            throw err;
        }
        await prisma.cart_item.delete({
            where: { id: +cart_item_id }
        });
        return true;
    },

    clearCart: async function (args: any, req: AuthRequest) {
        checkAuth(req);
        await prisma.cart_item.deleteMany({
            where: { user_id: req.id! }
        });
        return true;
    }
};

import prisma from '../../prisma';
import { AuthRequest } from '../../types/auth-request';
import { HttpError } from '../../types/error';
import { ProductFilterInput } from '../../types/graphql-inputs';

function checkAuth(req: any) {
    if (!req.isAuth) {
        const err: HttpError = new Error('Not authorized');
        err.statusCode = 401;
        throw err;
    }
}

export default {
    categories: async function () {
        return await prisma.category.findMany();
    },

    category: async function ({ id }: { id: string }) {
        const cat = await prisma.category.findUnique({ where: { id: +id } });
        if (!cat) {
            const err: HttpError = new Error('Category not found');
            err.statusCode = 404;
            throw err;
        }
        return cat;
    },

    products: async function ({ filter }: { filter?: ProductFilterInput }) {
        const where: any = {};
        if (filter) {
            if (filter.category_id) where.category_id = +filter.category_id;
            if (filter.search) where.name = { contains: filter.search, mode: 'insensitive' };
            if (filter.min_price !== undefined || filter.max_price !== undefined) {
                where.price = {};
                if (filter.min_price !== undefined) where.price.gte = filter.min_price;
                if (filter.max_price !== undefined) where.price.lte = filter.max_price;
            }
            if (filter.min_rating !== undefined) where.rating = { gte: filter.min_rating };
            if (filter.discount_only) where.discount = { gt: 0 };
            if (filter.free_shipping_only) where.free_shipping = true;
            if (filter.same_day_delivery_only) where.same_day_delivery = true;
        }

        return await prisma.product.findMany({
            where,
            take: filter?.limit,
            skip: filter?.offset
        });
    },

    product: async function ({ id }: { id: string }) {
        const prod = await prisma.product.findUnique({
            where: { id: +id },
            include: { category: true }
        });
        if (!prod) {
            const err: HttpError = new Error('Product not found');
            err.statusCode = 404;
            throw err;
        }
        return {
            ...prod,
            review: () => prisma.review.findMany({ where: { product_id: +id } })
        };
    },

    productReviews: async function ({ product_id }: { product_id: string }) {
        return await prisma.review.findMany({
            where: { product_id: +product_id }
        });
    },

    addReview: async function ({ product_id, rating, comment }: { product_id: string; rating: number; comment: string }, req: AuthRequest) {
        checkAuth(req);
        return await prisma.review.create({
            data: {
                product_id: +product_id,
                user_id: req.id!,
                rating,
                comment
            }
        });
    },

    toggleFavorite: async function ({ product_id }: { product_id: string }, req: AuthRequest) {
        checkAuth(req);
        const pId = +product_id;
        const existing = await prisma.favorite.findUnique({
            where: {
                user_id_product_id: {
                    user_id: req.id!,
                    product_id: pId
                }
            }
        });

        if (existing) {
            await prisma.favorite.delete({
                where: {
                    user_id_product_id: {
                        user_id: req.id!,
                        product_id: pId
                    }
                }
            });
            return false;
        } else {
            await prisma.favorite.create({
                data: {
                    user_id: req.id!,
                    product_id: pId
                }
            });
            return true;
        }
    }
};

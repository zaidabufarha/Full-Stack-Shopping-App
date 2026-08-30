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
        const list = await prisma.category.findMany();
        return list.map(c => ({ ...c, color: c.color.toString() }));
    },

    category: async function ({ id }: { id: string }) {
        const cat = await prisma.category.findUnique({ where: { id: +id } });
        if (!cat) {
            const err: HttpError = new Error('Category not found');
            err.statusCode = 404;
            throw err;
        }
        return { ...cat, color: cat.color.toString() };
    },

    products: async function ({ filter }: { filter?: ProductFilterInput }, req: any) {
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

        const list = await prisma.product.findMany({
            where,
            take: filter?.limit,
            skip: filter?.offset,
            include: {
                category: true,
                favorite: req?.isAuth && req?.id ? { where: { user_id: req.id } } : false,
                review: {
                    include: {
                        user: true
                    }
                }
            }
        });

        return list.map((p: any) => ({
            ...p,
            color: p.color.toString(),
            category: p.category ? { ...p.category, color: p.category.color.toString() } : undefined,
            is_favorite: Boolean(p.favorite && p.favorite.length > 0),
            review: (p.review || []).map((r: any) => ({
                ...r,
                created_at: r.created_at ? new Date(r.created_at).toISOString() : r.created_at
            }))
        }));
    },

    product: async function ({ id }: { id: string }, req: any) {
        const prod = await prisma.product.findUnique({
            where: { id: +id },
            include: {
                category: true,
                favorite: req?.isAuth && req?.id ? { where: { user_id: req.id } } : false,
                review: {
                    include: {
                        user: true
                    }
                }
            }
        });
        if (!prod) {
            const err: HttpError = new Error('Product not found');
            err.statusCode = 404;
            throw err;
        }
        return {
            ...prod,
            color: prod.color.toString(),
            category: prod.category ? { ...prod.category, color: prod.category.color.toString() } : undefined,
            is_favorite: Boolean((prod as any).favorite && (prod as any).favorite.length > 0),
            review: ((prod as any).review || []).map((r: any) => ({
                ...r,
                created_at: r.created_at ? new Date(r.created_at).toISOString() : r.created_at
            }))
        };
    },

    productReviews: async function ({ product_id }: { product_id: string }) {
        const list = await prisma.review.findMany({
            where: { product_id: +product_id },
            include: {
                user: true
            }
        });
        return list.map(r => ({
            ...r,
            created_at: r.created_at ? new Date(r.created_at).toISOString() : r.created_at
        }));
    },

    addReview: async function ({ product_id, rating, comment }: { product_id: string; rating: number; comment: string }, req: AuthRequest) {
        checkAuth(req);
        const pId = +product_id;
        const review = await prisma.review.create({
            data: {
                product_id: pId,
                user_id: req.id!,
                rating,
                comment
            },
            include: {
                user: true
            }
        });

        const allReviews = await prisma.review.findMany({
            where: { product_id: pId }
        });
        const totalRating = allReviews.reduce((sum, r) => sum + Number(r.rating), 0);
        const avgRating = allReviews.length > 0 ? totalRating / allReviews.length : 0;

        await prisma.product.update({
            where: { id: pId },
            data: {
                rating: avgRating
            }
        });

        return {
            ...review,
            created_at: review.created_at ? new Date(review.created_at).toISOString() : review.created_at
        };
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

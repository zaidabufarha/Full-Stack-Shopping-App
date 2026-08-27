import prisma from '../../prisma'
import { AuthRequest } from '../../types/auth-request'
const bcrypt = require('bcryptjs')
const fs = require('fs')
const jwt = require('jsonwebtoken')
const validator = require('validator')
import { HttpError } from '../../types/error'
import {
    OrderInput
} from '../../types/graphql-inputs'
import product from './product'


function checkAuth(req: any) {
    if (!req.isAuth) {
        const err: HttpError = new Error('Not authorized')
        err.statusCode = 401
        throw err
    }
}

export default {
    createOrder: async function (args: OrderInput, req: AuthRequest) { // get almost all the data internally instead of having it all as arguments
        checkAuth(req)

        const cartItems = await prisma.cart_item.findMany({
            where: { user_id: req.id! },
            include: { product: true }
        })
        if (cartItems.length === 0) {
            const err: HttpError = new Error('No items in cart')
            err.statusCode = 404
            throw err
        }
        else {
            //not empty cart
            let sum = 0
            cartItems.forEach(item => { //decimal needs to be converted to number
                sum += item.product.price.toNumber() * (1 - item.product.discount.toNumber()) * (item.quantity)
            })
            return await prisma.$transaction(async (tx) => { //transaction means that it all has to work to be done or it all rolls back. no cleared carts without orders or vice versa
                const newOrder = await tx.order.create({
                    data: {
                        user_id: req.id!,
                        address_id: +args.address_id,
                        card_id: +args.card_id,
                        total_amount: sum,
                        //we also need to add order items using the id of this order. we have a relationship that simplifies this
                        order_item: {
                            create: cartItems.map(item => ({ product_id: item.product_id, quantity: item.quantity, price_at_purchase: item.product.price.toNumber() * (1 - item.product.discount.toNumber()) }))
                        }
                    },
                    include: {
                        order_item: { include: { product: { include: { category: true } } } },
                        address: true,
                        credit_card: true
                    }

                })
                //clear cart
                await tx.cart_item.deleteMany({
                    where: { user_id: req.id! }
                })

                return newOrder
            })
        }
    },

    order: async function ({ id }: { id: string }, req: AuthRequest) {
        checkAuth(req)
        const order = await prisma.order.findUnique({
            where: { id: +id },
            include: { order_item: { include: { product: { include: { category: true } } } }, address: true, credit_card: true }
        });
        if (!order) {
            const err: HttpError = new Error('Order not found')
            err.statusCode = 404
            throw err
        }
        else if (order.user_id != req.id) {
            const err: HttpError = new Error('Not authorized')
            err.statusCode = 401
            throw err
        }
        else {
            return order
        }
    }

}

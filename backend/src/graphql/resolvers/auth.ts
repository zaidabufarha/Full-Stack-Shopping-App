import prisma from '../../prisma';
import { AuthRequest } from '../../types/auth-request';
const bcrypt = require('bcryptjs')
const fs = require('fs')
const jwt = require('jsonwebtoken')
const validator = require('validator')
import { HttpError } from '../../types/error';


function checkAuth(req: any) { //cleanest code of all time ever
    if (!req.isAuth) {
        const err: HttpError = new Error('Not authorized')
        err.statusCode = 401
        throw err
    }
}

export default {
    signUp: async function ({ email, number, password }: { email: string, number: string, password: string }, req: any) {
        if (await prisma.user.findUnique({
            where: { email: email }
        })) {
            const err: HttpError = new Error('Email already in use. Try logging in if it\'s your email.')
            err.statusCode = 422
            throw err
        }
        if (!validator.isEmail(email)) {
            const err: HttpError = new Error('Invalid email')
            err.statusCode = 422
            throw err
        }
        else if (!validator.isLength(password, { min: 8, max: 30 })) {
            const err: HttpError = new Error('Password must be between 8 and 30 characters')
            err.statusCode = 422
            throw err
        }
        //now we know we have valid input and a unique email
        const hashedPassword = await bcrypt.hash(password, 10);
        return await prisma.user.create({
            data: {
                email: email,
                phone: number,
                password: hashedPassword,
                name: 'User',
                image_path: 'assets/blank_profile_picture.png',
                notification_preference: {
                    create: {}
                }
            }
        });
    },

    logIn: async function ({ email, password }: { email: string, password: string }, req: any) {
        try {
            const user = await prisma.user.findUnique({
                where: { email: email }
            })
            if (user) {
                if (await bcrypt.compare(password, user.password)) {
                    const token = jwt.sign({ userId: user.id }, process.env.JWT_SECRET, { expiresIn: '1d' })
                    return { token: token, user: user }
                }
                else {
                    const err: HttpError = new Error('Incorrect password')
                    err.statusCode = 401
                    throw err
                }
            }
            else {
                const err: HttpError = new Error('User not found, check the email and try again.')
                err.statusCode = 404
                throw err
            }
        }
        catch (err: any) {
            if (!err.statusCode) {
                err.statusCode = 500
            }
            throw err
        }
    },
    changePassword: async function ({ oldPassword, newPassword }: { oldPassword: string, newPassword: string }, req: AuthRequest) {
        checkAuth(req);
        if (!validator.isLength(newPassword, { min: 8, max: 30 })) {
            const err: HttpError = new Error('Password must be between 8 and 30 characters');
            err.statusCode = 422;
            throw err;
        }
        const user = await prisma.user.findUnique({
            where: { id: req.id! }
        });
        if (!user) {
            const err: HttpError = new Error('User does not exist');
            err.statusCode = 404;
            throw err;
        }
        const isEqual = await bcrypt.compare(oldPassword, user.password);
        if (!isEqual) {
            const err: HttpError = new Error('Incorrect current password');
            err.statusCode = 401;
            throw err;
        }
        const hashedPassword = await bcrypt.hash(newPassword, 10);
        await prisma.user.update({
            where: { id: req.id! },
            data: { password: hashedPassword }
        });
        return true;
    }
};
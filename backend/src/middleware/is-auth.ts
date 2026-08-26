const jwt = require('jsonwebtoken')
import { Response, NextFunction } from 'express';
import { AuthRequest } from '../types/auth-request'

//instead of throwing I'll use flags. this way I can ignore it for signup and login

module.exports = (req: AuthRequest, res: Response, next: NextFunction) => {
    try {
        const token = req.get('Authorization')!.split(' ')[1] //after 'Bearer '
        const decodedToken = jwt.verify(token, process.env.JWT_SECRET)
        if (decodedToken) {
            req.id = decodedToken.userId
            req.isAuth = true
            return next()
        }
        else {
            req.isAuth = false
            return next()
        }

    }
    catch (err) {
        req.isAuth = false
        return next()
    }
}
import { Request } from 'express';

export interface AuthRequest extends Request {
    isAuth?: boolean;
    id?: number;
}

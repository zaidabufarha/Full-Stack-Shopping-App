//this file exist so i can split up my resolvers

import authResolvers from './auth';
import userResolvers from './user';
import productResolvers from './product';
import cartResolvers from './cart';
import orderResolvers from './order';

export default {
    ...authResolvers,
    ...userResolvers,
    ...productResolvers,
    ...cartResolvers,
    ...orderResolvers
};


import { describe, it, expect, beforeEach } from 'vitest';
import request from 'supertest';
import jwt from 'jsonwebtoken';
import app from '../src/app';
import prisma from '../src/prisma';

describe('Cart & Order GraphQL API (Protected Operations)', () => {
  const testUserId = 1;
  let authToken: string;

  beforeEach(() => {
    authToken = jwt.sign({ userId: testUserId }, process.env.JWT_SECRET || 'test_jwt_secret', {
      expiresIn: '1d',
    });
  });

  describe('Unauthenticated access guards', () => {
    it('fails addToCart when no Authorization header is provided', async () => {
      const query = `
        mutation {
          addToCart(product_id: "1", quantity: 2) {
            id
            quantity
          }
        }
      `;

      const res = await request(app)
        .post('/graphql')
        .send({ query });

      expect(res.body.errors).toBeDefined();
      expect(res.body.errors[0].message).toContain('Not authorized');
      expect(prisma.cart_item.upsert).not.toHaveBeenCalled();
    });

    it('fails createOrder (checkout) when no Authorization header is provided', async () => {
      const query = `
        mutation {
          createOrder(address_id: "1", card_id: "1", shipping_method: "Standard") {
            id
            total_amount
          }
        }
      `;

      const res = await request(app)
        .post('/graphql')
        .send({ query });

      expect(res.body.errors).toBeDefined();
      expect(res.body.errors[0].message).toContain('Not authorized');
      expect(prisma.$transaction).not.toHaveBeenCalled();
    });

    it('fails updateProfile when no Authorization header is provided', async () => {
      const query = `
        mutation {
          updateProfile(input: { name: "New Name", phone: "1234567890" }) {
            name
          }
        }
      `;

      const res = await request(app)
        .post('/graphql')
        .send({ query });

      expect(res.body.errors).toBeDefined();
      expect(res.body.errors[0].message).toContain('Not authorized');
      expect(prisma.user.update).not.toHaveBeenCalled();
    });
  });

  describe('Authenticated user operations', () => {
    it('successfully adds an item to the cart', async () => {
      const mockUpsertedCartItem = {
        id: 1,
        user_id: testUserId,
        product_id: 1,
        quantity: 2,
        product: {
          id: 1,
          name: 'Fresh Organic Broccoli',
          image_path: 'assets/broccoli.png',
          amount: '1 kg',
          description: 'Fresh broccoli',
          discount: 0,
          price: 4.99,
          is_new: true,
          free_shipping: true,
          same_day_delivery: false,
          color: '0xFFE6F2EA',
          rating: 4.8,
          category: {
            id: 1,
            name: 'Vegetables',
            image_path: 'assets/vegetables.png',
            color: '0xFFE6F2EA',
          },
          favorite: [],
        },
      };

      (prisma.cart_item.upsert as any).mockResolvedValue(mockUpsertedCartItem);

      const query = `
        mutation {
          addToCart(product_id: "1", quantity: 2) {
            id
            quantity
            product {
              id
              name
            }
          }
        }
      `;

      const res = await request(app)
        .post('/graphql')
        .set('Authorization', `Bearer ${authToken}`)
        .send({ query })
        .expect(200);

      expect(res.body.errors).toBeUndefined();
      expect(res.body.data.addToCart).toEqual({
        id: '1',
        quantity: 2,
        product: {
          id: '1',
          name: 'Fresh Organic Broccoli',
        },
      });
      expect(prisma.cart_item.upsert).toHaveBeenCalledWith({
        where: {
          user_id_product_id: {
            user_id: testUserId,
            product_id: 1,
          },
        },
        update: {
          quantity: { increment: 2 },
        },
        create: {
          user_id: testUserId,
          product_id: 1,
          quantity: 2,
        },
        include: {
          product: {
            include: {
              category: true,
              favorite: { where: { user_id: testUserId } },
            },
          },
        },
      });
    });

    it('successfully executes checkout (createOrder) from items in cart', async () => {
      const mockCartItems = [
        {
          id: 1,
          user_id: testUserId,
          product_id: 1,
          quantity: 2,
          product: {
            id: 1,
            name: 'Fresh Organic Broccoli',
            price: { toNumber: () => 10.0 },
            discount: { toNumber: () => 0.0 },
          },
        },
      ];

      const mockCreatedOrder = {
        id: 100,
        user_id: testUserId,
        address_id: 1,
        card_id: 1,
        total_amount: 20.0,
        shipping_method: 'Standard',
        status: 'Placed',
        date_placed: new Date().toISOString(),
        order_item: [
          {
            id: 1,
            order_id: 100,
            product_id: 1,
            quantity: 2,
            price_at_purchase: 10.0,
            product: {
              id: 1,
              name: 'Fresh Organic Broccoli',
              image_path: 'assets/broccoli.png',
              amount: '1 kg',
              description: 'Fresh broccoli',
              discount: 0,
              price: 10.0,
              is_new: true,
              free_shipping: true,
              same_day_delivery: false,
              color: '0xFFE6F2EA',
              rating: 4.8,
              category: {
                id: 1,
                name: 'Vegetables',
                image_path: 'assets/vegetables.png',
                color: '0xFFE6F2EA',
              },
              favorite: [],
            },
          },
        ],
        address: {
          id: 1,
          user_id: testUserId,
          name: 'Home',
          street: '123 Main St',
          city: 'Amman',
          zip_code: '11181',
          country: 'Jordan',
          phone: '0790000000',
        },
        credit_card: {
          id: 1,
          user_id: testUserId,
          card_holder_name: 'Zaid A',
          last4: '4444',
          expiry_date: '12/28',
          stripe_payment_id: 'pm_12345',
          processor: 'Visa',
        },
      };

      (prisma.cart_item.findMany as any).mockResolvedValue(mockCartItems);
      (prisma.order.create as any).mockResolvedValue(mockCreatedOrder);
      (prisma.cart_item.deleteMany as any).mockResolvedValue({ count: 1 });

      const query = `
        mutation {
          createOrder(address_id: "1", card_id: "1", shipping_method: "Standard") {
            id
            total_amount
            status
            order_item {
              quantity
              price_at_purchase
              product {
                name
              }
            }
          }
        }
      `;

      const res = await request(app)
        .post('/graphql')
        .set('Authorization', `Bearer ${authToken}`)
        .send({ query })
        .expect(200);

      expect(res.body.errors).toBeUndefined();
      expect(res.body.data.createOrder).toEqual({
        id: '100',
        total_amount: 20.0,
        status: 'Placed',
        order_item: [
          {
            quantity: 2,
            price_at_purchase: 10.0,
            product: {
              name: 'Fresh Organic Broccoli',
            },
          },
        ],
      });
      expect(prisma.cart_item.findMany).toHaveBeenCalledWith({
        where: { user_id: testUserId },
        include: { product: true },
      });
      expect(prisma.$transaction).toHaveBeenCalled();
    });
  });
});

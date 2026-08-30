import { describe, it, expect, beforeEach } from 'vitest';
import request from 'supertest';
import jwt from 'jsonwebtoken';
import app from '../src/app';
import prisma from '../src/prisma';

describe('Product & Category GraphQL API', () => {
  const testUserId = 1;
  let authToken: string;

  beforeEach(() => {
    authToken = jwt.sign({ userId: testUserId }, process.env.JWT_SECRET || 'test_jwt_secret', {
      expiresIn: '1d',
    });
  });

  describe('categories query', () => {
    it('returns a list of categories', async () => {
      const mockCategories = [
        {
          id: 1,
          name: 'Vegetables',
          image_path: 'assets/vegetables.png',
          color: '0xFFE6F2EA',
        },
        {
          id: 2,
          name: 'Fruits',
          image_path: 'assets/fruits.png',
          color: '0xFFFFEAEA',
        },
      ];

      (prisma.category.findMany as any).mockResolvedValue(mockCategories);

      const query = `
        query {
          categories {
            id
            name
            image_path
            color
          }
        }
      `;

      const res = await request(app)
        .post('/graphql')
        .send({ query })
        .expect(200);

      expect(res.body.errors).toBeUndefined();
      expect(res.body.data.categories).toEqual([
        {
          id: '1',
          name: 'Vegetables',
          image_path: 'assets/vegetables.png',
          color: '0xFFE6F2EA',
        },
        {
          id: '2',
          name: 'Fruits',
          image_path: 'assets/fruits.png',
          color: '0xFFFFEAEA',
        },
      ]);
      expect(prisma.category.findMany).toHaveBeenCalled();
    });
  });

  describe('products query', () => {
    it('returns a list of products', async () => {
      const mockProducts = [
        {
          id: 1,
          category_id: 1,
          name: 'Fresh Organic Broccoli',
          image_path: 'assets/broccoli.png',
          amount: '1 kg',
          description: 'Fresh and organic broccoli',
          discount: 0.1,
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
      ];

      (prisma.product.findMany as any).mockResolvedValue(mockProducts);

      const query = `
        query {
          products {
            id
            name
            price
            discount
            category {
              name
            }
          }
        }
      `;

      const res = await request(app)
        .post('/graphql')
        .send({ query })
        .expect(200);

      expect(res.body.errors).toBeUndefined();
      expect(res.body.data.products).toEqual([
        {
          id: '1',
          name: 'Fresh Organic Broccoli',
          price: 4.99,
          discount: 0.1,
          category: {
            name: 'Vegetables',
          },
        },
      ]);
      expect(prisma.product.findMany).toHaveBeenCalled();
    });
  });

  describe('product query (single product)', () => {
    it('returns a single product by valid ID', async () => {
      const mockProduct = {
        id: 1,
        category_id: 1,
        name: 'Fresh Organic Broccoli',
        image_path: 'assets/broccoli.png',
        amount: '1 kg',
        description: 'Fresh and organic broccoli',
        discount: 0.1,
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
      };

      (prisma.product.findUnique as any).mockResolvedValue(mockProduct);

      const query = `
        query {
          product(id: "1") {
            id
            name
            price
            description
            category {
              id
              name
            }
          }
        }
      `;

      const res = await request(app)
        .post('/graphql')
        .send({ query })
        .expect(200);

      expect(res.body.errors).toBeUndefined();
      expect(res.body.data.product).toEqual({
        id: '1',
        name: 'Fresh Organic Broccoli',
        price: 4.99,
        description: 'Fresh and organic broccoli',
        category: {
          id: '1',
          name: 'Vegetables',
        },
      });
      expect(prisma.product.findUnique).toHaveBeenCalledWith({
        where: { id: 1 },
        include: {
          category: true,
          favorite: false,
          review: {
            include: {
              user: true,
            },
          },
        },
      });
    });

    it('returns an error when querying a product with an invalid ID', async () => {
      (prisma.product.findUnique as any).mockResolvedValue(null);

      const query = `
        query {
          product(id: "999") {
            id
            name
          }
        }
      `;

      const res = await request(app)
        .post('/graphql')
        .send({ query });

      expect(res.body.errors).toBeDefined();
      expect(res.body.errors[0].message).toContain('Product not found');
    });
  });

  describe('addReview mutation', () => {
    it('creates review and recalculates average rating on product', async () => {
      const mockCreatedReview = {
        id: 10,
        product_id: 1,
        user_id: testUserId,
        rating: 4.0,
        comment: 'Great product!',
        created_at: new Date().toISOString(),
        user: {
          name: 'Test User',
          image_path: 'assets/user.png',
        },
      };

      (prisma.review.create as any).mockResolvedValue(mockCreatedReview);
      (prisma.review.findMany as any).mockResolvedValue([
        { rating: 5.0 },
        { rating: 3.0 },
        { rating: 4.0 },
      ]);
      (prisma.product.update as any).mockResolvedValue({ id: 1, rating: 4.0 });

      const query = `
        mutation {
          addReview(product_id: "1", rating: 4.0, comment: "Great product!") {
            id
            rating
            comment
          }
        }
      `;

      const res = await request(app)
        .post('/graphql')
        .set('Authorization', `Bearer ${authToken}`)
        .send({ query })
        .expect(200);

      expect(res.body.errors).toBeUndefined();
      expect(res.body.data.addReview).toEqual({
        id: '10',
        rating: 4.0,
        comment: 'Great product!',
      });
      expect(prisma.review.create).toHaveBeenCalledWith({
        data: {
          product_id: 1,
          user_id: testUserId,
          rating: 4.0,
          comment: 'Great product!',
        },
        include: {
          user: true,
        },
      });
      expect(prisma.product.update).toHaveBeenCalledWith({
        where: { id: 1 },
        data: {
          rating: 4.0,
        },
      });
    });
  });
});

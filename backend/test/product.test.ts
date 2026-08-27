import { describe, it, expect, beforeEach } from 'vitest';
import request from 'supertest';
import app from '../src/app';
import prisma from '../src/prisma';

describe('Product & Category GraphQL API', () => {
  beforeEach(() => {
    // Reset mocks
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
});

import { describe, it, expect, beforeEach, vi } from 'vitest';
import request from 'supertest';
import bcrypt from 'bcryptjs';
import app from '../src/app';
import prisma from '../src/prisma';

describe('Auth GraphQL API', () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  describe('signUp mutation', () => {
    it('successfully creates a user with valid credentials', async () => {
      const mockCreatedUser = {
        id: 1,
        email: 'newuser@example.com',
        phone: '1234567890',
        name: 'User',
        image_path: 'assets/blank_profile_picture.png',
        notification_preference: {
          id: 1,
          user_id: 1,
          allow_general: true,
          allow_order: true,
          allow_email: true,
        },
        address: [],
        credit_card: [],
        order: [],
        transaction: [],
        favorite: [],
      };

      (prisma.user.findUnique as any).mockResolvedValue(null);
      (prisma.user.create as any).mockResolvedValue(mockCreatedUser);

      const query = `
        mutation {
          signUp(email: "newuser@example.com", number: "1234567890", password: "password123") {
            id
            email
            name
          }
        }
      `;

      const res = await request(app)
        .post('/graphql')
        .send({ query })
        .expect(200);

      expect(res.body.errors).toBeUndefined();
      expect(res.body.data.signUp).toEqual({
        id: '1',
        email: 'newuser@example.com',
        name: 'User',
      });
      expect(prisma.user.findUnique).toHaveBeenCalledWith({
        where: { email: 'newuser@example.com' },
      });
      expect(prisma.user.create).toHaveBeenCalled();
    });

    it('fails signup when email is already in use', async () => {
      (prisma.user.findUnique as any).mockResolvedValue({
        id: 1,
        email: 'existing@example.com',
      });

      const query = `
        mutation {
          signUp(email: "existing@example.com", number: "1234567890", password: "password123") {
            id
            email
          }
        }
      `;

      const res = await request(app)
        .post('/graphql')
        .send({ query });

      expect(res.body.errors).toBeDefined();
      expect(res.body.errors[0].message).toContain('Email already in use');
      expect(prisma.user.create).not.toHaveBeenCalled();
    });
  });

  describe('logIn mutation', () => {
    it('successfully logs in with valid credentials and returns token and user info', async () => {
      const hashedPassword = await bcrypt.hash('password123', 10);
      const mockUser = {
        id: 1,
        email: 'valid@example.com',
        password: hashedPassword,
        name: 'John Doe',
        phone: '1234567890',
        image_path: 'assets/blank_profile_picture.png',
        notification_preference: {
          id: 1,
          user_id: 1,
          allow_general: true,
          allow_order: true,
          allow_email: true,
        },
        address: [],
        credit_card: [],
        order: [],
        transaction: [],
        favorite: [],
      };

      (prisma.user.findUnique as any).mockResolvedValue(mockUser);

      const query = `
        mutation {
          logIn(email: "valid@example.com", password: "password123") {
            token
            user {
              id
              name
              email
            }
          }
        }
      `;

      const res = await request(app)
        .post('/graphql')
        .send({ query })
        .expect(200);

      expect(res.body.errors).toBeUndefined();
      expect(res.body.data.logIn.token).toBeDefined();
      expect(typeof res.body.data.logIn.token).toBe('string');
      expect(res.body.data.logIn.user).toEqual({
        id: '1',
        name: 'John Doe',
        email: 'valid@example.com',
      });
    });

    it('fails login with incorrect password', async () => {
      const hashedPassword = await bcrypt.hash('correctpassword', 10);
      (prisma.user.findUnique as any).mockResolvedValue({
        id: 1,
        email: 'valid@example.com',
        password: hashedPassword,
      });

      const query = `
        mutation {
          logIn(email: "valid@example.com", password: "wrongpassword") {
            token
          }
        }
      `;

      const res = await request(app)
        .post('/graphql')
        .send({ query });

      expect(res.body.errors).toBeDefined();
      expect(res.body.errors[0].message).toContain('Incorrect password');
    });

    it('fails login with unregistered email', async () => {
      (prisma.user.findUnique as any).mockResolvedValue(null);

      const query = `
        mutation {
          logIn(email: "nonexistent@example.com", password: "password123") {
            token
          }
        }
      `;

      const res = await request(app)
        .post('/graphql')
        .send({ query });

      expect(res.body.errors).toBeDefined();
      expect(res.body.errors[0].message).toContain('User not found');
    });
  });
});

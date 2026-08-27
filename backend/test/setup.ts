import { vi } from 'vitest';

process.env.NODE_ENV = 'test';
process.env.JWT_SECRET = process.env.JWT_SECRET || 'test_jwt_secret_key_1234567890';
process.env.DATABASE_URL = process.env.DATABASE_URL || 'postgresql://test:test@localhost:5432/testdb';
process.env.RESEND_API_KEY = process.env.RESEND_API_KEY || 're_test_key_123456';

const mockPrismaClient: any = {
  user: {
    findUnique: vi.fn(),
    findFirst: vi.fn(),
    findMany: vi.fn(),
    create: vi.fn(),
    update: vi.fn(),
    delete: vi.fn(),
  },
  notification_preference: {
    findUnique: vi.fn(),
    create: vi.fn(),
    update: vi.fn(),
  },
  address: {
    findUnique: vi.fn(),
    findMany: vi.fn(),
    create: vi.fn(),
    update: vi.fn(),
    delete: vi.fn(),
    updateMany: vi.fn(),
  },
  credit_card: {
    findUnique: vi.fn(),
    findMany: vi.fn(),
    create: vi.fn(),
    update: vi.fn(),
    delete: vi.fn(),
    updateMany: vi.fn(),
  },
  category: {
    findUnique: vi.fn(),
    findMany: vi.fn(),
  },
  product: {
    findUnique: vi.fn(),
    findMany: vi.fn(),
  },
  review: {
    findMany: vi.fn(),
    create: vi.fn(),
  },
  cart_item: {
    findUnique: vi.fn(),
    findMany: vi.fn(),
    create: vi.fn(),
    update: vi.fn(),
    delete: vi.fn(),
    deleteMany: vi.fn(),
    upsert: vi.fn(),
  },
  order: {
    findUnique: vi.fn(),
    findMany: vi.fn(),
    create: vi.fn(),
  },
  transaction: {
    findMany: vi.fn(),
    create: vi.fn(),
  },
  favorite: {
    findUnique: vi.fn(),
    create: vi.fn(),
    delete: vi.fn(),
  },
  $transaction: vi.fn(async (callback: any) => callback(mockPrismaClient)),
};

vi.mock('../src/prisma', () => ({
  default: mockPrismaClient,
}));

afterEach(() => {
  vi.clearAllMocks();
});

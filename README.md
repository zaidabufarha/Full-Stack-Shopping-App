# BigCart

A full-stack grocery shopping mobile app built with Flutter, Express, GraphQL, and PostgreSQL. 

Tested and optimized for Android.

## Tech Stack & Architecture

- **Mobile Frontend**: 
  - Flutter (Dart) with Clean Architecture (Domain, Data, and Presentation layers)
  - State Management: Cubit
  - Dependency Injection: `get_it` + `injectable`
  - Networking: Dio GraphQL client with automated token interceptors
- **Backend API**: Node.js, Express, TypeScript, GraphQL, Prisma ORM
- **Database & Hosting**: PostgreSQL (Aiven), API hosted on Render
- **Media CDN**: Cloudinary for asset storage & dynamic delivery

## Features

- **Authentication & Security**: Email/Password registration & login with phone OTP verification flow (no SMS messaging implemented, code is always 123456), email-based password recovery with Resend, and JWT session persistence.
- **Account & Profile Management**: Update personal info (name, email, phone), password change, profile picture upload via Cloudinary, and notification preferences.
- **Address & Card Management**: Manage saved shipping addresses and payment methods with default selection support.
- **Product Catalog**: Categorized products with multi-parameter filtering (price range, ratings, same-day delivery, discounts) and real-time search.
- **Cart & Favorites**: Real-time subtotal & total calculation with support for discounts, item quantity adjustment, and swipe-to-delete actions.
- **Checkout & Orders**: Multi-step checkout pipeline and order history with dynamic 5-stage status timeline.
- **Reviews & Ratings**: Product reviews and customer feedback submission.
- **CI/CD & DevOps**: GitHub Actions automated pipeline (Flutter & Node.js unit tests + automated Render deployment).


## Setup & Running

### 1. Backend
(create a .env file with DATABASE_URL, JWT_SECRET, RESEND_API_KEY, and NODE_TLS_REJECT_UNAUTHORIZED=0)
```bash
cd backend
npm install
npx prisma db push
npx tsx prisma/seed.ts
npm run dev
```
### 2. Mobile Frontend
```bash
cd mobile_frontend
flutter pub get
flutter run
```



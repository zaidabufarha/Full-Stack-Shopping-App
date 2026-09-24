import { createBrowserRouter, Navigate } from "react-router-dom";
import RootLayout from "../components/layout/RootLayout";
import AccountLayout from "../features/account/AccountLayout";
import HomePage from "../features/buy/pages/HomePage";
import LoginPage from "../features/auth/pages/LoginPage";
import SignUpPage from "../features/auth/pages/SignUpPage";
import CartPage from "../features/buy/pages/CartPage";
import ProductPage from "../features/buy/pages/ProductPage";
import ReviewsPage from "../features/buy/pages/ReviewsPage";
import WriteReviewPage from "../features/buy/pages/WriteReviewPage";
import ContactPage from "../pages/ContactPage";
import NotificationsPage from "../features/account/pages/NotificationsPage";
import ProfilePage from "../features/account/pages/ProfilePage";
import OrdersPage from "../features/account/pages/OrdersPage";
import AddressesPage from "../features/account/pages/AddressesPage";
import CardsPage from "../features/account/pages/CardsPage";
import TransactionsPage from "../features/account/pages/TransactionsPage";
import TrackOrderPage from "../features/account/pages/TrackOrderPage";

export const router = createBrowserRouter([
  {
    element: <RootLayout />,
    children: [
      { index: true, element: <HomePage /> },
      { path: "contact", element: <ContactPage /> },
      { path: "login", element: <LoginPage /> },
      { path: "signup", element: <SignUpPage /> },
      { path: "cart", element: <CartPage /> },
      {
        // nested layout: sidebar + <Outlet />, itself inside RootLayout's outlet
        path: "account",
        element: <AccountLayout />,
        children: [
          { index: true, element: <Navigate to="/account/profile" replace /> },
          { path: "profile", element: <ProfilePage /> },
          { path: "orders", element: <OrdersPage /> },
          { path: "orders/:id", element: <TrackOrderPage /> },
          { path: "addresses", element: <AddressesPage /> },
          { path: "cards", element: <CardsPage /> },
          { path: "transactions", element: <TransactionsPage /> },
          { path: "notifications", element: <NotificationsPage /> },
        ],
      },
      { path: "favorites", element: <HomePage favorites /> },
      { path: "product/:id", element: <ProductPage /> },
      { path: "product/:id/reviews", element: <ReviewsPage /> },
      { path: "product/:id/reviews/new", element: <WriteReviewPage /> },
    ],
  },
]);

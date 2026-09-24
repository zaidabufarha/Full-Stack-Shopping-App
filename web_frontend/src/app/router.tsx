import { createBrowserRouter, Navigate } from "react-router-dom";
import RootLayout from "../components/layout/RootLayout";
import AccountLayout from "../features/account/AccountLayout";
import HomePage from "../features/buy/pages/HomePage";
import LoginPage from "../features/auth/pages/LoginPage";
import SignUpPage from "../features/auth/pages/SignUpPage";
import CartPage from "../features/buy/pages/CartPage";
import CheckoutLayout from "../features/buy/CheckoutLayout";
import DeliveryStep from "../features/buy/pages/checkout/DeliveryStep";
import AddressStep from "../features/buy/pages/checkout/AddressStep";
import PaymentStep from "../features/buy/pages/checkout/PaymentStep";
import OrderSuccessPage from "../features/buy/pages/checkout/OrderSuccessPage";
import ProductPage from "../features/buy/pages/ProductPage";
import ReviewsPage from "../features/buy/pages/ReviewsPage";
import WriteReviewPage from "../features/buy/pages/WriteReviewPage";
import ContactPage from "../pages/ContactPage";
import ErrorPage from "../pages/ErrorPage";
import NotFoundPage from "../pages/NotFoundPage";
import NotificationsPage from "../features/account/pages/NotificationsPage";
import ProfilePage from "../features/account/pages/ProfilePage";
import OrdersPage from "../features/account/pages/OrdersPage";
import AddressesPage from "../features/account/pages/AddressesPage";
import CardsPage from "../features/account/pages/CardsPage";
import TransactionsPage from "../features/account/pages/TransactionsPage";
import TrackOrderPage from "../features/account/pages/TrackOrderPage";

/** Dev only: a page that throws on render, to see the error boundary. */
function Crash(): never {
  throw new Error("Test crash from /__crash — this is the error boundary working.");
}

export const router = createBrowserRouter([
  {
    element: <RootLayout />,
    // last resort: the layout itself (nav, footer) threw — standalone error page
    errorElement: <ErrorPage />,
    children: [
      {
        // pathless boundary: a page error renders here, inside RootLayout's
        // Outlet, so nav and footer stay up around it
        errorElement: <ErrorPage />,
        children: [
          { index: true, element: <HomePage /> },
          { path: "contact", element: <ContactPage /> },
          { path: "login", element: <LoginPage /> },
          { path: "signup", element: <SignUpPage /> },
          { path: "cart", element: <CartPage /> },
          {
            // nested layout: step indicator + order summary around the current step
            path: "checkout",
            element: <CheckoutLayout />,
            children: [
              {
                index: true,
                element: <Navigate to="/checkout/delivery" replace />,
              },
              { path: "delivery", element: <DeliveryStep /> },
              { path: "address", element: <AddressStep /> },
              { path: "payment", element: <PaymentStep /> },
            ],
          },
          // outside the layout: the cart is empty by now, which would bounce it
          { path: "checkout/success/:orderId", element: <OrderSuccessPage /> },
          {
            // nested layout: sidebar + <Outlet />, itself inside RootLayout's outlet
            path: "account",
            element: <AccountLayout />,
            children: [
              {
                index: true,
                element: <Navigate to="/account/profile" replace />,
              },
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
          // dev only — stripped from the production build by the DEV check
          ...(import.meta.env.DEV ? [{ path: "__crash", element: <Crash /> }] : []),
          // anything that matched nothing above
          { path: "*", element: <NotFoundPage /> },
        ],
      },
    ],
  },
]);

import { createBrowserRouter } from "react-router-dom";
import RootLayout from "../components/layout/RootLayout";
import HomePage from "../features/buy/pages/HomePage";
import ShopPage from "../features/buy/pages/ShopPage";
import CategoryPage from "../features/buy/pages/CategoryPage";
import LoginPage from "../features/auth/pages/LoginPage";
import SignUpPage from "../features/auth/pages/SignUpPage";
import CartPage from "../features/buy/pages/CartPage";
import ContactPage from "../pages/ContactPage";

export const router = createBrowserRouter([
  {
    element: <RootLayout />,
    children: [
      { index: true, element: <HomePage /> },
      { path: "shop", element: <ShopPage /> },
      { path: "category", element: <CategoryPage /> },
      { path: "contact", element: <ContactPage /> },
      { path: "login", element: <LoginPage /> },
      { path: "signup", element: <SignUpPage /> },
      { path: "cart", element: <CartPage /> },
    ],
  },
]);

import { Outlet } from "react-router-dom";
import { Box } from "@mantine/core";
import TopBar from "./TopBar";
import NavBar from "./NavBar";
import Footer from "./Footer";

function RootLayout() {
  return (
    <>
      <TopBar />
      <NavBar />
      <Outlet />
      <Footer />
    </>
  );
}

export default RootLayout;

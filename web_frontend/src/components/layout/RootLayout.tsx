import { Outlet } from "react-router-dom";
import { Box, useMantineTheme } from "@mantine/core";
import TopBar from "./TopBar";
import NavBar from "./NavBar";
import Footer from "./Footer";

function RootLayout() {
  const theme = useMantineTheme();

  return (
    <>
      <TopBar />
      <NavBar />
      <Box bg={theme.other.bgSecondary} mih={"25vh"}>
        <Outlet />
      </Box>
      <Footer />
    </>
  );
}

export default RootLayout;

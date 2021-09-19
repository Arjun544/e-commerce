import { useState, createContext } from "react";
import "./App.css";
import SideBar from "./components/SideBar";
import TopBar from "./components/TopBar";
import Dashboard from "./pages/dashboard/Dashboard";
import { BrowserRouter, Switch, Route, Redirect } from "react-router-dom";
import Login from "./pages/Login/Login";
import { SnackbarProvider } from "notistack";
import Grow from "@material-ui/core/Grow";
import { useMediaQuery } from "react-responsive";
import Orders from "./pages/orders/Orders";
import Products from "./pages/products/Products";

export const AppContext = createContext(null);

function App() {
  const [isSideBarOpen, setIsSideBarOpen] = useState(true);
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const isBigScreen = useMediaQuery({ query: "(min-width: 1824px)" });
  return (
    <SnackbarProvider
      maxSnack={2}
      anchorOrigin={{
        vertical: "top",
        horizontal: "center",
      }}
      TransitionComponent={Grow}
    >
      <AppContext.Provider
        value={{
          isSideBarOpen,
          setIsSideBarOpen,
          isBigScreen,
          isMenuOpen,
          setIsMenuOpen,
        }}
      >
        <div className=" w-screen h-screen m-0 box-border bg-white">
          <BrowserRouter>
            <Switch>
              <Route path="/login">
                <Login />
              </Route>
              <div className="flex h-full w-full bg-white">
                {isBigScreen ? (
                  <SideBar />
                ) : (
                  isMenuOpen && (
                    <div className="h-full absolute top-0 left-0 z-50">
                      <SideBar />
                    </div>
                  )
                )}
                <div className="flex flex-col w-full">
                  <TopBar />
                  <Route path="/" exact>
                    <Dashboard />
                  </Route>
                  <Route path="/orders">
                    <Orders />
                  </Route>
                  <Route path="/products">
                    <Products />
                  </Route>
                </div>
              </div>
            </Switch>
          </BrowserRouter>
        </div>
      </AppContext.Provider>
    </SnackbarProvider>
  );
}

export default App;

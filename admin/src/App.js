import { useState, createContext, useEffect, useRef } from "react";
import "./App.css";
import SideBar from "./components/SideBar";
import Dashboard from "./pages/dashboard/Dashboard";
import FilterOrder from "./pages/dashboard/components/FilterOrder";
import { BrowserRouter, Switch, Route } from "react-router-dom";
import Login from "./pages/Login/Login";
import { SnackbarProvider } from "notistack";
import Grow from "@material-ui/core/Grow";
import { useMediaQuery } from "react-responsive";
import { io } from "socket.io-client";
import Orders from "./pages/orders/Orders";
import Products from "./pages/products/Products";
import { ProtectedRoute } from "./protected_route";
import { GuestRoute } from "./protected_route";
import Loader from "react-loader-spinner";
import ProductDetail from "./pages/ProductDetail/ProductDetail";
import Categories from "./pages/categories/Categories";
import AddProduct from "./pages/AddProduct/AddProduct";
import Banners from "./pages/Banners/Banners";
import FlashDeal from "./pages/FlashDeal/FlashDeal";
import Customers from "./pages/Customers/Customers";
import CustomerDetails from "./pages/CustomerDetails/CustomerDetails";
import Reviews from "./pages/Reviews/Reviews";

export const AppContext = createContext(null);

function App() {
  const socketUrl = io("http://localhost:4000");
  let socket = useRef(null);

  const [isSideBarOpen, setIsSideBarOpen] = useState(true);
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const [isLoading, setIsLoading] = useState(false);

  const isBigScreen = useMediaQuery({ query: "(min-width: 1824px)" });

  useEffect(() => {
    socket.current = io(socketUrl, {
      autoConnect: false,
    });
    socket.current.on("connection", () => {
      console.log("connected to server");
    });

    socket.current.on("disconnect", () => {
      console.log("Socket disconnecting");
    });
  }, [socketUrl]);

  return isLoading ? (
    <div className="flex w-full h-screen items-center justify-center bg-white">
      <Loader
        type="Puff"
        color="#00BFFF"
        height={50}
        width={50}
        timeout={3000} //3 secs
      />
    </div>
  ) : (
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
          socket,
          isSideBarOpen,
          setIsSideBarOpen,
          isBigScreen,
          isMenuOpen,
          setIsMenuOpen,
          setIsLoading,
        }}
      >
        <div className=" w-screen h-screen m-0 box-border bg-white">
          <BrowserRouter>
            <Switch>
              <GuestRoute exact path="/login">
                <Login />
              </GuestRoute>
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

                <ProtectedRoute path="/" exact>
                  <Dashboard />
                </ProtectedRoute>
                <ProtectedRoute path="/dashboard/orders/:status" exact>
                  <FilterOrder />
                </ProtectedRoute>
                <ProtectedRoute path="/orders" exact>
                  <Orders />
                </ProtectedRoute>
                <ProtectedRoute path="/products" exact>
                  <Products />
                </ProtectedRoute>
                <ProtectedRoute path="/categories" exact>
                  <Categories />
                </ProtectedRoute>
                <ProtectedRoute path="/products/view/:id" exact>
                  <ProductDetail />
                </ProtectedRoute>
                <ProtectedRoute path="/products/add" exact>
                  <AddProduct isEditing={false} />
                </ProtectedRoute>
                <ProtectedRoute path="/products/edit/:id" exact>
                  <AddProduct isEditing={true} />
                </ProtectedRoute>
                <ProtectedRoute path="/banners" exact>
                  <Banners />
                </ProtectedRoute>
                <ProtectedRoute path="/flashDeal" exact>
                  <FlashDeal />
                </ProtectedRoute>
                <ProtectedRoute path="/customers" exact>
                  <Customers />
                </ProtectedRoute>
                <ProtectedRoute path="/customers/view/:id" exact>
                  <CustomerDetails />
                </ProtectedRoute>
                <ProtectedRoute path="/reviews" exact>
                  <Reviews />
                </ProtectedRoute>
              </div>
            </Switch>
          </BrowserRouter>
        </div>
      </AppContext.Provider>
    </SnackbarProvider>
  );
}

export default App;

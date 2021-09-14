import { useState, createContext } from "react";
import "./App.css";
import SideBar from "./components/SideBar";
import TopBar from "./components/TopBar";
import Dashboard from "./pages/dashboard/Dashboard";

export const AppContext = createContext(null);

function App() {
  const [isSideBarOpen, setIsSideBarOpen] = useState(true);
  return (
    <AppContext.Provider value={{ isSideBarOpen, setIsSideBarOpen }}>
      <div className="flex flex-col w-screen h-screen m-0 box-border bg-white">
        <div className="flex h-screen">
          <SideBar />
          <div className="flex flex-col w-full">
            <TopBar />
            <Dashboard />
          </div>
        </div>
      </div>
    </AppContext.Provider>
  );
}

export default App;

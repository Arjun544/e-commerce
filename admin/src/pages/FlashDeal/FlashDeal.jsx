import React, { useEffect, useState, useContext } from "react";
import TopBar from "../../components/TopBar";
import Loader from "react-loader-spinner";
import {
  getDeals,
} from "../../api/dealApi";
import { Accordion } from "react-sanfona";
import { AppContext } from "../../App";
import AddDeal from "./components/AddDeal";
import AddProductsDialogue from "./components/AddProductsDialogue";
import { getProducts } from "../../api/productsApi";
import ReactTooltip from "react-tooltip";
import DealItem from "./components/DealItem";

const FlashDeal = () => {
  const { socket } = useContext(AppContext);
  const [deals, setDeals] = useState([]);
  const [products, setProducts] = useState([]);
  const [currentDeal, setCurrentDeal] = useState({});
  const [editingDeal, setEditingDeal] = useState({});
 const [isTileOpen, setIsTileOpen] = useState(false);
  const [isEditing, setIsEditing] = useState(false);

  const [addProductsDialogue, setAddProductsDialogue] = useState(false);
  const [isInitLoading, setIsInitLoading] = useState(false);

  useEffect(() => {
    const getAllDeals = async () => {
      setIsInitLoading(true);
      const { data } = await getDeals();
      setDeals(data.deals);
      const response = await getProducts(false);
      setProducts(response.data.results);
      setIsInitLoading(false);
    };

    getAllDeals();
  }, []);

  return (
    <div className="flex-col w-full h-full overflow-hidden bg-white">
      {addProductsDialogue && (
        <div className=" flex absolute z-50 left-0 w-screen h-screen bg-blue-light bg-opacity-0 backdrop-filter backdrop-blur-sm justify-center items-center">
          <AddProductsDialogue
            setDeals={setDeals}
            currentDeal={currentDeal}
            products={products}
            setAddProductsDialogue={setAddProductsDialogue}
          />
        </div>
      )}

      <TopBar></TopBar>

      <div className="flex-col h-full w-full items-center px-8 mt-2">
        <span className="text-black font-semibold text-xl">Flash Deal</span>
        {/* Add deal */}
        <AddDeal
          socket={socket}
          isEditing={isEditing}
          setIsEditing={setIsEditing}
          editingDeal={editingDeal}
          setDeals={setDeals}
        ></AddDeal>
        {/* Deals */}
        <div className="flex items-center mt-10 gap-3">
          <span className="text-black font-semibold text-md ">Deals</span>
          <div
            data-tip="Set Status to on, to start the deal"
            className="h-5 w-5 rounded-md bg-Grey-dark flex items-center justify-center cursor-pointer"
          >
            <span className="font-semibold text-sm text-white tracking-wide">
              !
            </span>
          </div>
          <ReactTooltip
            place="top"
            type="info"
            effect="solid"
            offset={{ top: 5 }}
          />
        </div>
        {isInitLoading ? (
          <div className="flex w-full items-center justify-center bg-white">
            <Loader
              type="Puff"
              color="#00BFFF"
              height={50}
              width={50}
              timeout={3000} //3 secs
            />
          </div>
        ) : deals.length === 0 ? (
          <div className="flex items-center justify-center mt-20">
            <span className="text-gray-400 font-semibold">No Deals</span>
          </div>
        ) : (
          <div className="flex-col">
            <Accordion
              className="h-auto flex-col pt-5 items-start mb-6 "
              isHovered={true}
            >
              {deals.map((deal) => {
                return (
                  <DealItem
                    deal={deal}
                    setDeals={setDeals}
                    setCurrentDeal={setCurrentDeal}
                    setAddProductsDialogue={setAddProductsDialogue}
                    setIsEditing={setIsEditing}
                    setEditingDeal={setEditingDeal}
                    isTileOpen={isTileOpen}
                    setIsTileOpen={setIsTileOpen}
                  />
                );
              })}
            </Accordion>
          </div>
        )}
      </div>
    </div>
  );
};

export default FlashDeal;

import React, { useEffect, useState, useContext } from "react";
import TopBar from "../../components/TopBar";

import EditIcon from "../../components/icons/EditIcon";
import DeleteIcon from "../../components/icons/DeleteIcon";
import FlipCountdown from "@rumess/react-flip-countdown";
import Switch from "react-switch";
import Loader from "react-loader-spinner";
import dateFormat from "dateformat";
import { useSnackbar } from "notistack";
import { addDeal, deleteDeal, getDeals } from "../../api/dealApi";
import { Accordion, AccordionItem } from "react-sanfona";
import { ChevronDownIcon } from "@heroicons/react/solid";
import { ChevronUpIcon } from "@heroicons/react/solid";
import { AppContext } from "../../App";
import AddDeal from "./components/AddDeal";
import AddProductsDialogue from "./components/AddProductsDialogue";
import { getProducts } from "../../api/productsApi";

const FlashDeal = () => {
  Date.prototype.addHours = function (h) {
    this.setHours(this.getHours() + h);
    return this;
  };
  const { socket } = useContext(AppContext);
  const [deals, setDeals] = useState([]);
  const [products, setProducts] = useState([]);
  const [currentDeal, setCurrentDeal] = useState({});
  const [counterEnd, setCounterEnd] = useState("");
  const [editingDeal, setEditingDeal] = useState({});
  const [statusValue, setStatusValue] = useState(false);
  const [isEditing, setIsEditing] = useState(false);
  const [isTileOpen, setIsTileOpen] = useState(false);
  const [addProductsDialogue, setAddProductsDialogue] = useState(false);
  const { enqueueSnackbar, closeSnackbar } = useSnackbar();
  const [isInitLoading, setIsInitLoading] = useState(false);
  const [startDateTime, setStartDateTime] = useState(new Date());
  const [endDateTime, setEndDateTime] = useState(new Date().addHours(1));

  useEffect(() => {
    const getAllDeals = async () => {
      setIsInitLoading(true);
      const { data } = await getDeals();
      setDeals(data.deals);
      const response = await getProducts();
      setProducts(response.data.products);
      setIsInitLoading(false);
      setCounterEnd(data.deals.map((item) => item.endDate));
    };
    getAllDeals();
  }, []);

  const handleStatus = (e) => {
    e.preventDefault();
  };

  const handleAddProducts = (e, deal) => {
    e.preventDefault();
    setCurrentDeal(deal);
    setAddProductsDialogue(true);
  };

  const handleEdit = (e, deal) => {
    e.preventDefault();
    setIsEditing(true);
    setEditingDeal(deal);
    setStartDateTime(deal.startDate);
    setEndDateTime(deal.endDate);
  };

  const handleDealDelete = async (e, id) => {
    e.preventDefault();
    await deleteDeal(id);
    socket.current.on("delete-deal", (newDeals) => {
      setDeals(newDeals);
      setCounterEnd();
    });
    enqueueSnackbar("Deal deleted", {
      variant: "success",
      autoHideDuration: 2000,
    });
  };

  const handleProductDelete = (e) => {
    e.preventDefault();
  };

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
          deals={deals}
          setDeals={setDeals}
          startDateTime={startDateTime}
          setStartDateTime={setStartDateTime}
          endDateTime={endDateTime}
          setEndDateTime={setEndDateTime}
          setCounterEnd={setCounterEnd}
        ></AddDeal>
        {/* Deal */}
        {isInitLoading ? (
          <div className="flex w-full h-screen items-center justify-center bg-white">
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
          <div className="flex-col mt-12">
            <div className="flex items-center">
              {new Date(counterEnd[0]) < new Date() ? (
                <span className="text-red-500 font-semibold text-md pt-5">
                  Deal Expired
                </span>
              ) : (
                <span className="text-black font-semibold text-md pt-5">
                  Deal Ends In
                </span>
              )}
              {/* Timer */}
              <div className="flex items-center ml-4 text-gray-400 font-semibold text-xs">
                <FlipCountdown
                  yearTitle="Y"
                  monthTitle="M"
                  dayTitle="D"
                  hourTitle="H"
                  minuteTitle="M"
                  secondTitle="S"
                  endAtZero
                  theme="light"
                  size="small"
                  endAt={counterEnd[0]}
                />
              </div>
            </div>

            <Accordion
              className="h-auto flex-col pt-3  items-start mb-6 "
              isHovered={true}
            >
              {deals.map((deal) => {
                return (
                  <AccordionItem
                    key={deal._id}
                    className="mb-4"
                    onExpand={() => setIsTileOpen(true)}
                    onClose={() => setIsTileOpen(false)}
                    title={
                      <div
                        className={`flex h-16 items-center bg-bgColor-light border-none px-4 ${
                          !isTileOpen ? "rounded-2xl" : "rounded-t-2xl"
                        }  shadow-sm justify-between justify-items-center cursor-pointer hover:shadow-md`}
                      >
                        <span
                          className={
                            "font-medium text-black overflow-hidden truncate w-32"
                          }
                        >
                          {deal.title.charAt(0).toUpperCase() +
                            deal.title.slice(1)}
                        </span>
                        <div className="flex items-center">
                          <span className="text-gray-400 font-semibold text-sm mr-2">
                            Start
                          </span>
                          <span className="text-black font-semibold">
                            {dateFormat(
                              deal.startDate,
                              "mmmm d, yyyy, h:MM:ss TT"
                            )}
                          </span>
                        </div>
                        {/* End Date */}
                        <div className="flex items-center">
                          <span className="text-gray-400 font-semibold text-sm mr-2">
                            End
                          </span>
                          <span className="text-black font-semibold">
                            {dateFormat(
                              deal.endDate,
                              "mmmm d, yyyy, h:MM:ss TT"
                            )}
                          </span>
                        </div>

                        <div className="flex items-center">
                          <span className="text-black font-semibold mr-4">
                            Status
                          </span>
                          <Switch
                            checked={deal.status}
                            onChange={handleStatus}
                            onColor="#D1FAE5"
                            onHandleColor="#10B981"
                            handleDiameter={20}
                            uncheckedIcon={false}
                            checkedIcon={false}
                            boxShadow="0px 1px 5px rgba(0, 0, 0, 0.329)"
                            activeBoxShadow="0px 0px 1px 10px rgba(0, 0, 0, 0.062)"
                            height={10}
                            width={30}
                            className="react-switch"
                            id="material-switch"
                          />
                        </div>

                        <div
                          onClick={(e) => handleAddProducts(e, deal)}
                          className="flex items-center justify-center h-8 w-28 rounded-xl bg-darkBlue-light cursor-pointer transform hover:scale-95  transition duration-500 ease-in-out"
                        >
                          <span className="text-white font-semibold text-sm">
                            Add Product
                          </span>
                        </div>

                        <div className="flex items-center">
                          <div className="flex items-end mr-6">
                            <EditIcon
                              onClick={(e) => handleEdit(e, deal)}
                              className="mr-3 h-5 w-5 cursor-pointer fill-lightGreen hover:fill-green"
                            />
                            <DeleteIcon
                              onClick={(e) => handleDealDelete(e, deal._id)}
                              className="cursor-pointer h-5 w-5 fill-lightRed hover:fill-red"
                            />
                          </div>
                          {isTileOpen ? (
                            <ChevronUpIcon className="h-6 w-6 relative text-black cursor-pointer"></ChevronUpIcon>
                          ) : (
                            <ChevronDownIcon className="h-6 w-6 relative text-black cursor-pointer"></ChevronDownIcon>
                          )}
                        </div>
                      </div>
                    }
                    expanded={deal === 1}
                  >
                    <div className="flex flex-wrap h-auto bg-bgColor-light bg-opacity-50 w-full p-6">
                      {deal.products.length === 0 ? (
                        <span className="text-gray-400 font-semibold">
                          No Products
                        </span>
                      ) : (
                        deal.products.map((item, index) => (
                          <div
                            key={index}
                            className="flex w-80 h-16 mr-8 mb-6  bg-blue-light bg-opacity-30 rounded-2xl items-center justify-between px-6 shadow-sm"
                          >
                            <div className="flex items-center">
                              <img
                                className="h-8 w-8 rounded-full mr-2"
                                src={item.thumbnail}
                                alt=""
                              />
                              <span className="text-black font-semibold capitalize mr-4">
                                {item.name}
                              </span>
                              <span className="text-green-400 font-semibold capitalize">
                                {`${item.discount}% OFF`}
                              </span>
                            </div>
                            <div className="flex">
                              <DeleteIcon
                                onClick={(e) =>
                                  handleProductDelete(
                                    e,
                                    deal._id,
                                    item._id,
                                    item.price
                                  )
                                }
                                className="cursor-pointer h-5 w-5 fill-grey hover:fill-red"
                              />
                            </div>
                          </div>
                        ))
                      )}
                    </div>
                  </AccordionItem>
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

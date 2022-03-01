import { ChevronDownIcon, ChevronUpIcon } from "@heroicons/react/solid";
import { useSnackbar } from "notistack";
import React, { useContext, useState } from "react";
import { AccordionItem } from "react-sanfona";
import { deleteDeal, removeDealProducts, updateStatus } from "../../../api/dealApi";
import { AppContext } from "../../../App";
import DeleteIcon from "../../../components/icons/DeleteIcon";
import EditIcon from "../../../components/icons/EditIcon";
import Status from "./Status";

const DealItem = ({
  deal,
  setDeals,
  setCurrentDeal,
  setAddProductsDialogue,
  setIsEditing,
  setEditingDeal,
  isTileOpen,
  setIsTileOpen,
}) => {
  const { socket } = useContext(AppContext);
  const [value, setValue] = useState(false);
  const { enqueueSnackbar } = useSnackbar();

  const handleAddProducts = (e, deal) => {
    e.preventDefault();
    setCurrentDeal(deal);
    setAddProductsDialogue(true);
  };

  const handleEdit = (e, deal) => {
    e.preventDefault();
    setIsEditing(true);
    setEditingDeal(deal);
  };

  const handleDealDelete = async (e, id) => {
    e.preventDefault();
    await deleteDeal(id);
    socket.current.on("delete-deal", (newDeals) => {
      setDeals(newDeals);
    });
    enqueueSnackbar("Deal deleted", {
      variant: "success",
      autoHideDuration: 2000,
    });
  };

  const handleProductDelete = async (
    e,
    index,
    deal,
    productId,
    productPrice
  ) => {
    e.preventDefault();
    try {
      await removeDealProducts(deal._id, productId, productPrice);
      socket.current.on("remove-dealProduct", async (newDeals) => {
        setDeals(newDeals);

        // Update status off, if products are empty
        if (newDeals[index].products.length === 0) {
          await updateStatus(deal._id, false);
          socket.current.on("update-dealStatus", (newValue) => {
            setValue(newValue);
          });
        }
      });
      enqueueSnackbar("Product deleted", {
        variant: "success",
        autoHideDuration: 2000,
      });
    } catch (error) {
      console.log(error.response);
      enqueueSnackbar("Something went wrong", {
        variant: "error",
        autoHideDuration: 2000,
      });
    }
  };

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
            className={"font-medium text-black overflow-hidden truncate w-32"}
          >
            {deal.title.charAt(0).toUpperCase() + deal.title.slice(1)}
          </span>

          <div className="flex items-center">
            <span className="text-black font-semibold mr-4">Status</span>
            <Status value={value} setValue={setValue} deal={deal} />
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
          <span className="text-gray-400 font-semibold">No Products</span>
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
                    handleProductDelete(e, index, deal, item._id, item.price)
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
};

export default DealItem;

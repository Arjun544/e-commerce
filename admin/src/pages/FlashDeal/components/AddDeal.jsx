import React, { useState } from "react";
import { useSnackbar } from "notistack";
import { addDeal, updateDeal } from "../../../api/dealApi";
import Loader from "react-loader-spinner";

const AddDeal = ({
  socket,
  isEditing,
  setIsEditing,
  editingDeal,
  setDeals,
}) => {
  const [isLoading, setIsLoading] = useState(false);
  const [input, setInput] = useState("");
  const { enqueueSnackbar } = useSnackbar();

  const handleAddDeal = async (e) => {
    e.preventDefault();
    if (!input) {
      enqueueSnackbar("Title is required", {
        variant: "error",
        autoHideDuration: 2000,
      });
    } else {
      try {
        setIsLoading(true);
        await addDeal(input);
        setIsLoading(false);
        socket.current.on("add-deal", (newDeals) => {
          setDeals(newDeals);
        });
        setInput("");
        enqueueSnackbar("Deal added", {
          variant: "success",
          autoHideDuration: 2000,
        });
      } catch (error) {
        setIsLoading(false);
        console.log(error.response);
        enqueueSnackbar("Something went wrong", {
          variant: "error",
          autoHideDuration: 2000,
        });
      }
    }
  };

  const handleEditDeal = async (e) => {
    e.preventDefault();
    if (!input) {
      enqueueSnackbar("Title is required", {
        variant: "error",
        autoHideDuration: 2000,
      });
    } else {
      try {
        setIsLoading(true);
        await updateDeal(editingDeal._id, input);
        setIsLoading(false);
        socket.current.on("edit-deal", (newDeals) => {
          setDeals(newDeals);
        });
        setInput("");
        setIsEditing(false);
        enqueueSnackbar("Deal updated", {
          variant: "success",
          autoHideDuration: 2000,
        });
      } catch (error) {
        setIsLoading(false);
        console.log(error.response);
        enqueueSnackbar("Something went wrong", {
          variant: "error",
          autoHideDuration: 2000,
        });
      }
    }
  };

  return (
    <div className="flex-col mt-6">
      <span className="text-black font-semibold text-md">
        {isEditing ? "Edit Deal" : "Add Deal"}
      </span>
      <div className="flex-col w-full items-center rounded-2xl bg-bgColor-light mt-4 px-4 py-8">
        <input
          className="h-14 w-full rounded-xl font-semibold text-black bg-white px-4 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent "
          placeholder={isEditing ? editingDeal.title : "Title"}
          value={input}
          onChange={(e) => {
            e.preventDefault();
            setInput(e.target.value);
          }}
        />
        <div className="flex items-center justify-center mt-14">
          {isLoading ? (
            <div className="flex items-center justify-center ml-2">
              <Loader type="Puff" color="#00BFFF" height={50} width={50} />
            </div>
          ) : (
            <div className="flex items-center">
              <div
                onClick={isEditing ? handleEditDeal : handleAddDeal}
                className={`flex h-12 ${
                  isEditing
                    ? "bg-customYellow-light"
                    : input !== ""
                    ? "bg-customYellow-light"
                    : "bg-gray-400"
                } shadow-sm border-none w-40 rounded-xl  items-center justify-center cursor-pointer transform hover:scale-95  transition duration-500 ease-in-out`}
              >
                <span className="font-semibold text-sm text-white">
                  {isEditing ? " Update Deal" : " Add Deal"}
                </span>
              </div>
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

export default AddDeal;

import React, { useState } from "react";
import TopBar from "../../components/TopBar";
import { DateTimePicker } from "react-rainbow-components";
import EditIcon from "../../components/icons/EditIcon";
import DeleteIcon from "../../components/icons/DeleteIcon";
import Switch from "react-switch";

const FlashDeal = () => {
  Date.prototype.addHours = function (h) {
    this.setHours(this.getHours() + h);
    return this;
  };

  const [input, setInput] = useState("");
  const [value, setValue] = useState(false);
  const [startDateTime, setStartDateTime] = useState(new Date());
  const [endDateTime, setsEndDateTime] = useState(new Date().addHours(1));

  const handleAddDeal = (e) => {
    e.preventDefault();
  };

  const handleStaus = (e) => {
    e.preventDefault();
    };
    
    const handleAddProducts = (e) => {
        e.preventDefault();
    }

  return (
    <div className="flex-col w-full h-full overflow-hidden bg-white">
      <TopBar></TopBar>

      <div className="flex-col h-full w-full items-center px-8 mt-2">
        <span className="text-black font-semibold text-xl">Flash Deal</span>
        {/* Add deal */}
        <div className="flex-col mt-6">
          <span className="text-black font-semibold text-md">Add Deal</span>
          <div className="flex-col w-full items-center rounded-2xl bg-bgColor-light mt-4 px-4 py-6">
            <input
              className="h-14 w-full rounded-xl font-semibold text-black bg-white px-4 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent "
              placeholder="Title"
              value={input}
              onChange={(e) => {
                e.preventDefault();
                setInput(e.target.value);
              }}
            />
            <div className="flex flex-grow mt-6">
              <div className="flex-col items-center w-full mr-6">
                <span className="text-black font-semibold text-sm">
                  Start Date
                </span>
                <DateTimePicker
                  className=" mt-2"
                  id="datetimepicker-11"
                  hour24
                  minDate={new Date()}
                  placeholder="Start date and time"
                  value={startDateTime}
                  hideLabel={true}
                  onChange={(value) => setStartDateTime(value)}
                />
              </div>

              <div className="flex-col w-full items-center">
                <span className="text-black font-semibold text-sm">
                  End Date
                </span>
                <DateTimePicker
                  className=" mt-2"
                  id="datetimepicker-12"
                  hour24
                  minDate={new Date()}
                  placeholder="End date and time"
                  value={endDateTime}
                  hideLabel={true}
                  onChange={(value) => setsEndDateTime(value)}
                />
              </div>
            </div>
            <div className="flex items-center justify-center mt-10">
              <div
                onClick={handleAddDeal}
                className="flex h-12 bg-customYellow-light shadow-sm border-none w-40 rounded-xl  items-center justify-center cursor-pointer transform hover:scale-95  transition duration-500 ease-in-out"
              >
                <span className="font-semibold text-sm text-white">
                  Add Deal
                </span>
              </div>
            </div>
          </div>
        </div>
        {/* Deal */}
        <div className="flex-col mt-8">
          <span className="text-black font-semibold text-md">Deal</span>
          <div className="flex items-center justify-between h-16 px-4 mt-4 w-full rounded-2xl bg-bgColor-light">
            <span className="text-black font-semibold">Deal Name</span>
            {/* Start Date */}
            <div className="flex items-center">
              <span className="text-gray-400 font-semibold text-sm mr-2">
                Start
              </span>
              <span className="text-black font-semibold">
                {startDateTime.getDay().toString()}
              </span>
            </div>
            {/* End Date */}
            <div className="flex items-center">
              <span className="text-gray-400 font-semibold text-sm mr-2">
                End
              </span>
              <span className="text-black font-semibold">
                {startDateTime.getDay().toString()}
              </span>
            </div>
            {/* Status */}
            <div className="flex items-center">
              <span className="text-gray-400 font-semibold text-sm mr-2">
                Status
              </span>
              <Switch
                checked={value}
                onChange={handleStaus}
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
            {/* Add Product */}
            <div
              onClick={(e) => handleAddProducts(e)}
              className="flex items-center justify-center h-8 w-28 rounded-xl bg-darkBlue-light cursor-pointer transform hover:scale-95  transition duration-500 ease-in-out"
            >
              <span className="text-white font-semibold text-sm">
                Add Product
              </span>
            </div>
            {/* Actions */}
            <div className="flex items-end mr-6">
              <EditIcon
                // onClick={(e) => handleEdit(e, banner)}
                className="mr-3 h-5 w-5 cursor-pointer fill-lightGreen hover:fill-green"
              />
              <DeleteIcon
                // onClick={(e) => handleBannerDelete(e, banner)}
                className="cursor-pointer h-5 w-5 fill-lightRed hover:fill-red"
              />
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default FlashDeal;

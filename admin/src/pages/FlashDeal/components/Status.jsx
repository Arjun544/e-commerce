import React, { useEffect, useContext } from "react";
import Switch from "react-switch";
import { useSnackbar } from "notistack";
import { updateStatus } from "../../../api/dealApi";
import { AppContext } from "../../../App";

const Status = ({ deal, value, setValue }) => {
  const { socket } = useContext(AppContext);
  const { enqueueSnackbar } = useSnackbar();

  useEffect(() => {
    setValue(deal.status);
  }, []);

  const handleStatus = async (nextChecked) => {
    try {
      if (value === false && deal.products.length === 0) {
        enqueueSnackbar("Products can't be empty", {
          variant: "warning",
          autoHideDuration: 2000,
        });
      } else {
        await updateStatus(deal._id, nextChecked);
        socket.current.on("update-dealStatus", (newValue) => {
          setValue(newValue);
        });
        enqueueSnackbar("Status has been updated", {
          variant: "success",
          autoHideDuration: 2000,
        });
      }
    } catch (error) {
      console.log(error.response);
    }
  };
  return (
    <Switch
      value={value}
      checked={value}
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
  );
};

export default Status;

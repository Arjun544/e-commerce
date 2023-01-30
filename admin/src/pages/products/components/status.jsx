import React, { useState, useContext } from "react";
import Switch from "react-switch";
import { useSnackbar } from "notistack";
import { updateStatus } from "../../../api/productsApi";
import { AppContext } from "../../../App";

const Status = ({ product }) => {
  const { socket } = useContext(AppContext);
  const { enqueueSnackbar } = useSnackbar();
  const [value, setValue] = useState(product.status);

  const handleStatus = async (nextChecked) => {
    try {
      await updateStatus(product._id, nextChecked);
      socket.current.on("update-productStatus", (newValue) => {
        setValue(newValue);
      });
      enqueueSnackbar("Status has been updated", {
        variant: "success",
        autoHideDuration: 2000,
      });
    } catch (error) {}
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

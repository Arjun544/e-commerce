import React, { useState, useContext } from "react";
import Switch from "react-switch";
import { useSnackbar } from "notistack";
import { updateStatus } from "../../../api/bannersApi";
import { AppContext } from "../../../App";

const Status = ({ banner }) => {
  const { socket } = useContext(AppContext);
  const { enqueueSnackbar } = useSnackbar();
  const [value, setValue] = useState(banner.status);

  const handleStatus = async (nextChecked) => {
    try {
      if (banner.products.length === 0) {
        enqueueSnackbar("Products can't be empty", {
          variant: "warning",
          autoHideDuration: 2000,
        });
      } else {
        await updateStatus(banner._id, nextChecked);
        socket.current.on("update-bannerStatus", (newValue) => {
          setValue(newValue);
        });
        enqueueSnackbar("Status has been updated", {
          variant: "success",
          autoHideDuration: 2000,
        });
      }
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

import React, { useEffect, useContext, useState } from "react";
import Switch from "react-switch";
import { useSnackbar } from "notistack";
import { updateStatus } from "../../../api/categoriesApi";
import { AppContext } from "../../../App";

const CategoryStatus = ({ category }) => {
  const { socket } = useContext(AppContext);
  const [value, setValue] = useState(category.status);
  const { enqueueSnackbar, closeSnackbar } = useSnackbar();

  // useEffect(() => {
  //   setValue(category.status);
  // }, []);

  const handleStatus = async (nextChecked) => {
    try {
      await updateStatus(category._id, nextChecked);
      socket.current.on("update-categoryStatus", (newValue) => {
        setValue(newValue);
      });
      enqueueSnackbar("Status has been updated", {
        variant: "success",
        autoHideDuration: 2000,
      });
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

export default CategoryStatus;
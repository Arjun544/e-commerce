import React, { useContext } from "react";
import DeleteIcon from "../../../components/icons/DeleteIcon";
import { useSnackbar } from "notistack";
import { useHistory } from "react-router-dom";
import { AppContext } from "../../../App";
import { deleteUser } from "../../../api/userApi";

const TableAction = ({ user: review, setTableData }) => {
  const { socket } = useContext(AppContext);
  const history = useHistory();
  const { enqueueSnackbar, closeSnackbar } = useSnackbar();

  const handleDelete = async (e) => {
    e.preventDefault();
    try {
      await deleteUser(review._id, review.profileId);
      socket.current.on("delete-user", (newUsers) => {
        setTableData(newUsers);
      });
      enqueueSnackbar("User deleted", {
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
    <div className="flex ml-4">
      <DeleteIcon
        onClick={handleDelete}
        className="cursor-pointer h-5 w-5 fill-grey hover:fill-red"
      />
    </div>
  );
};

export default TableAction;

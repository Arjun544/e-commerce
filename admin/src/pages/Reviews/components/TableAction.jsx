import React, { useContext } from "react";
import DeleteIcon from "../../../components/icons/DeleteIcon";
import { useSnackbar } from "notistack";
import { AppContext } from "../../../App";
import { deleteUser } from "../../../api/userApi";

const TableAction = ({ user: review, setTableData }) => {
  const { socket } = useContext(AppContext);
  const { enqueueSnackbar } = useSnackbar();

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

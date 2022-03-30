import React, { useContext } from "react";
import DeleteIcon from "../../../components/icons/DeleteIcon";
import { useSnackbar } from "notistack";
import { AppContext } from "../../../App";
import { deleteUser } from "../../../api/userApi";

const TableActions = ({ user, tableData, setTableData }) => {
  const { socket } = useContext(AppContext);
  const { enqueueSnackbar } = useSnackbar();

  const handleDelete = async (e) => {
    e.preventDefault();
    setTableData({
      hasNextPage: tableData.hasNextPage,
      hasPrevPage: tableData.hasNextPage,
      page: tableData.page,
      total_pages: tableData.total_pages,
      total_results: tableData.total_results,
      results: tableData.results.filter((item) => item.id !== user.id),
    });
    enqueueSnackbar("User deleted", {
      variant: "success",
      autoHideDuration: 2000,
    });
    // try {
    //   await deleteUser(user._id, user.profileId);
    //   socket.current.on("delete-user", (newUsers) => {
    //     setTableData(newUsers);
    //   });
    //   enqueueSnackbar("User deleted", {
    //     variant: "success",
    //     autoHideDuration: 2000,
    //   });
    // } catch (error) {
    //
    //   enqueueSnackbar("Something went wrong", {
    //     variant: "error",
    //     autoHideDuration: 2000,
    //   });
    // }
  };

  return (
    <div className="flex ml-4">
      <DeleteIcon
        onClick={(e) => handleDelete(e)}
        className="cursor-pointer h-5 w-5 fill-grey hover:fill-red"
      />
    </div>
  );
};

export default TableActions;

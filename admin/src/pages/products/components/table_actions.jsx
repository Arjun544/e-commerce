import React, { useContext } from "react";
import EditIcon from "../../../components/icons/EditIcon";
import DeleteIcon from "../../../components/icons/DeleteIcon";
import { deleteProduct, getProducts } from "../../../api/productsApi";
import { useSnackbar } from "notistack";
import { useHistory } from "react-router-dom";
import { AppContext } from "../../../App";

const TableActions = ({ product, setIsLoading, tableData, setTableData }) => {
  const { socket } = useContext(AppContext);
  const history = useHistory();
  const { enqueueSnackbar, closeSnackbar } = useSnackbar();

  const handleDelete = async (e) => {
    e.preventDefault();
    setTableData({
      hasNextPage: tableData.hasNextPage,
      hasPrevPage: tableData.hasNextPage,
      page: tableData.page,
      total_pages: tableData.total_pages,
      total_results: tableData.total_results,
      results: tableData.results.filter((item) => item.id !== product.id),
    });
    enqueueSnackbar("Product deleted", {
      variant: "success",
      autoHideDuration: 2000,
    });
    // try {
    //   const ids = product.images.map((item) => item.id);
    //   await deleteProduct(product.id, product.thumbnailId, ids);
    //   socket.current.on("delete-product", (products) => {
    //     setTableData(products);
    //   });
    //   enqueueSnackbar("Product deleted", {
    //     variant: "success",
    //     autoHideDuration: 2000,
    //   });
    // } catch (error) {
    //   console.log(error.response);
    //   enqueueSnackbar(error.response.data.message, {
    //     variant: "error",
    //     autoHideDuration: 2000,
    //   });
    // }
  };

  const handleEdit = (e) => {
    e.preventDefault();
    history.push(`/products/edit/${product.id}`);
  };

  return (
    <div className="flex items-center">
      <EditIcon
        onClick={handleEdit}
        className="mr-2 h-5 w-5 cursor-pointer fill-grey hover:fill-green"
      />
      <DeleteIcon
        onClick={handleDelete}
        className="cursor-pointer h-5 w-5 fill-grey hover:fill-red"
      />
    </div>
  );
};

export default TableActions;

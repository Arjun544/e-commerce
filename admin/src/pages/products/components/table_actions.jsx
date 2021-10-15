import React from "react";
import EditIcon from "../../../components/icons/EditIcon";
import DeleteIcon from "../../../components/icons/DeleteIcon";
import { deleteProduct, getProducts } from "../../../api/productsApi";
import { useSnackbar } from "notistack";
import { useHistory } from "react-router-dom";

const TableActions = ({ product, setIsLoading, setTableData }) => {
  const history = useHistory();
  const { enqueueSnackbar, closeSnackbar } = useSnackbar();

  const handleDelete = async (e) => {
    e.preventDefault();
    try {
      const ids = product.images.map((item) => item.id);
      setIsLoading(true);
      await deleteProduct(product.id, product.thumbnailId, ids);
      const { data } = await getProducts();
      setTableData(data.products);
      setIsLoading(false);
       enqueueSnackbar("Product deleted", {
         variant: "success",
         autoHideDuration: 2000,
       });
    } catch (error) {
      console.log(error.response);
      enqueueSnackbar(error.response.data.message, {
        variant: "error",
        autoHideDuration: 2000,
      });
    } finally {
      setIsLoading(false);
    }
  };

  const handleEdit = (e) => {
    e.preventDefault();
    history.push(`/products/edit/${product.id}`);
  }
  return (
    <div className="flex">
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

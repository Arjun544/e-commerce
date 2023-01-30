import React, { useState, useEffect, useContext } from "react";
import ProductsDropDown from "./ProductsDropDown";
import  { Puff } from "react-loader-spinner";
import { useSnackbar } from "notistack";
import DeleteIcon from "../../../components/icons/DeleteIcon";
import { addBannerProducts } from "../../../api/bannersApi";
import { AppContext } from "../../../App";
const AddProductsDialogue = ({
  currentBanner,
  setBanners,
  products,
  setAddProductsDialogue,
}) => {
  const { socket } = useContext(AppContext);
  const [loading, setLoading] = useState(false);
  const { enqueueSnackbar } = useSnackbar();
  const [selectedProductName, setSelectedProductName] =
    useState("Select product");
  const [selectedProduct, setSelectedProduct] = useState({});
  const [addedProducts, setAddedProducts] = useState([]);
  const [searchInput, setSearchInput] = useState("");
  const [discountInput, setDiscountInput] = useState(1);
  const [discounts, setDiscounts] = useState([]);

  useEffect(() => {
    setAddedProducts(currentBanner.products);
    setDiscounts(currentBanner.products.map((item) => item.discount));
  }, [currentBanner.products]);

  const handleSave = async (e) => {
    e.preventDefault();
    const productObject = addedProducts.map((item, index) => ({
      id: item._id,
      price: item.price,
      discount: discounts[index],
    }));

    try {
      setLoading(true);
      await addBannerProducts(currentBanner._id, productObject, addedProducts);
      setLoading(false);
      socket.current.on("add-bannerProducts", (newBanners) => {
        setBanners(newBanners);
      });
      setAddProductsDialogue(false);
      enqueueSnackbar("Products added", {
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

  const handleAdd = (e, product) => {
    e.preventDefault();

    if (addedProducts.some((item) => item._id === product._id)) {
      enqueueSnackbar("Product already added", {
        variant: "warning",
        autoHideDuration: 2000,
      });
    } else if (discountInput <= 0) {
      enqueueSnackbar("Discount can't be zero", {
        variant: "warning",
        autoHideDuration: 2000,
      });
    } else if (discountInput > 100) {
      enqueueSnackbar("Discount can't be greater than 100", {
        variant: "warning",
        autoHideDuration: 2000,
      });
    } else if (selectedProductName !== "Select product") {
      setAddedProducts((prevState) => [...prevState, product]);
      setSelectedProductName("Select product");
      setDiscounts((prevState) => [...prevState, parseInt(discountInput)]);
      setSelectedProduct({});
    }
  };

  const handleProductRemove = (e, product) => {
    e.preventDefault();
    setAddedProducts(addedProducts.filter((item) => item._id !== product._id));
  };

  const calcDiscount = (price, discount) => {
    return price - (price * discount) / 100;
  };

  return (
    <div className="flex-col relative py-10 h-1/2 w-1/2 rounded-3xl bg-blue-light justify-center px-12">
      <div className="flex items-center">
        <ProductsDropDown
          products={products}
          selectedProductName={selectedProductName}
          setSelectedProductName={setSelectedProductName}
          setSelectedProduct={setSelectedProduct}
          searchInput={searchInput}
          setSearchInput={setSearchInput}
        />
        {selectedProductName !== "Select product" && (
          <input
            className="h-14 w-32 mr-8 rounded-xl font-semibold text-black bg-bgColor-light px-4 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent "
            placeholder="Discount in %"
            type="number"
            min="0"
            value={discountInput}
            onChange={(e) => {
              e.preventDefault();
              setDiscountInput(e.target.value);
            }}
          />
        )}

        <div
          onClick={(e) => handleAdd(e, selectedProduct)}
          className="flex items-center justify-center bg-darkBlue-light p-4 rounded-2xl cursor-pointer"
        >
          <span className="font-semibold text-sm text-white ">{"Add"}</span>
        </div>
      </div>
      {selectedProductName !== "Select product" && (
        <div className="flex mt-2">
          <span className="text-black font-semibold">{`Price after ${discountInput} % discount is ${calcDiscount(
            selectedProduct.price,
            discountInput
          )}`}</span>
        </div>
      )}
      {/* Products List */}

      <div className="flex-col mt-8">
        <span className="text-black font-semibold">Selected Products</span>
        <div className="flex flex-wrap ">
          {addedProducts.length !== 0 &&
            addedProducts.map((product, index) => (
              <div
                key={index}
                className="flex w-64 h-14 mr-4 mb-4 mt-3 bg-white rounded-2xl items-center justify-between px-6 shadow-sm"
              >
                <div className="flex">
                  <img
                    className="h-6 w-6 rounded-full mr-4"
                    src={product.thumbnail}
                    alt=""
                  />
                  <span className="text-black font-semibold capitalize">
                    {product.name}
                  </span>
                </div>
                <div className="flex">
                  <DeleteIcon
                    onClick={(e) => handleProductRemove(e, product)}
                    className="cursor-pointer h-4 w-4 fill-grey hover:fill-red"
                  />
                </div>
              </div>
            ))}
        </div>
      </div>

      <div className="flex absolute right-0 left-0 bottom-10 items-center justify-center mt-20">
        <div
          onClick={(e) => {
            e.preventDefault();
            setAddProductsDialogue(false);
          }}
          className="flex h-12 bg-red-500  shadow-sm border-none ml-4 w-32 rounded-xl  items-center justify-center cursor-pointer transform hover:scale-95  transition duration-500 ease-in-out"
        >
          <span className="font-semibold text-sm text-white">Cancel</span>
        </div>

        {loading ? (
          <div className="flex items-center justify-center ml-2">
            <Puff type="Puff" color="#00BFFF" height={50} width={50} />
          </div>
        ) : (
          <div
            onClick={handleSave}
            className="flex h-12 bg-green-500  shadow-sm border-none ml-4 w-32 rounded-xl  items-center justify-center cursor-pointer transform hover:scale-95  transition duration-500 ease-in-out"
          >
            <span className="font-semibold text-sm text-white">{"Save"}</span>
          </div>
        )}
      </div>
    </div>
  );
};

export default AddProductsDialogue;

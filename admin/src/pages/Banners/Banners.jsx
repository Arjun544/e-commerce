import React, { useEffect, useState, useContext } from "react";
import TopBar from "../../components/TopBar";
import Loader from "react-loader-spinner";
import { useSnackbar } from "notistack";
import { AppContext } from "../../App";
import {
  getBanners,
  deleteBanner,
  removeBannerProducts,
} from "../../api/bannersApi";
import AddBannerDialogue from "./components/AddBannerDialogue";
import { Accordion, AccordionItem } from "react-sanfona";
import EditIcon from "../../components/icons/EditIcon";
import DeleteIcon from "../../components/icons/DeleteIcon";
import { ChevronDownIcon } from "@heroicons/react/solid";
import { ChevronUpIcon } from "@heroicons/react/solid";
import Status from "./components/Status";
import { getProducts } from "../../api/productsApi";
import AddProductsDialogue from "./components/AddProductsDialogue";

const Banners = () => {
  const { socket } = useContext(AppContext);
  const [isLoading, setIsLoading] = useState(false);
  const { enqueueSnackbar } = useSnackbar();
  const [banners, setBanners] = useState([]);
  const [currentBanner, setCurrentBanner] = useState({});
  const [products, setProducts] = useState([]);
  const [isTileOpen, setIsTileOpen] = useState(false);
  const [addBannerAlert, setAddBannerAlert] = useState(false);
  const [addProductsDialogue, setAddProductsDialogue] = useState(false);
  const [isEditing, setIsEditing] = useState(false);
  const [editingBanner, setEditingBanner] = useState({});

  useEffect(() => {
    const fetchBanners = async () => {
      try {
        setIsLoading(true);
        const { data } = await getBanners();
        setBanners(data.banners);
        const response = await getProducts(false);
        setProducts(response.data.results);
        setIsLoading(false);
      } catch (error) {
        setIsLoading(false);

        enqueueSnackbar("Something went wrong", {
          variant: "error",
          autoHideDuration: 2000,
        });
      }
    };
    fetchBanners();
  }, []);
  const generalBanners = banners.filter((item) => item.type === "General");
  const saleBanners = banners.filter((item) => item.type === "Sale");

  const handleAdd = () => {
    setAddBannerAlert(true);
  };

  const handleAddProducts = (e, banner) => {
    e.preventDefault();
    setCurrentBanner(banner);
    setAddProductsDialogue(true);
  };

  const handleEdit = (e, banner) => {
    e.preventDefault();
    setAddBannerAlert(true);
    setIsEditing(true);
    setEditingBanner(banner);
  };

  const handleBannerDelete = async (e, banner) => {
    e.preventDefault();
    setBanners(banners.filter((item) => item.id !== banner.id));
    enqueueSnackbar("Banner deleted", {
      variant: "success",
      autoHideDuration: 2000,
    });
    // try {
    //   await deleteBanner(banner._id, banner.imageId);
    //   socket.current.on("delete-banner", (newBanners) => {
    //     setBanners(newBanners);
    //   });
    //   enqueueSnackbar("Banner deleted", {
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

  const handleProductDelete = async (e, bannerId, productId, productPrice) => {
    e.preventDefault();
    enqueueSnackbar("Product deleted", {
      variant: "success",
      autoHideDuration: 2000,
    });
    // try {
    //   await removeBannerProducts(bannerId, productId, productPrice);
    //   socket.current.on("remove-bannerProduct", (newBanners) => {
    //     setBanners(newBanners);
    //   });
    //   enqueueSnackbar("Product deleted", {
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
    <div className="flex-col w-full h-full overflow-hidden bg-white">
      {addBannerAlert && (
        <div className=" flex absolute z-50 left-0 w-screen h-screen bg-blue-light bg-opacity-0 backdrop-filter backdrop-blur-sm justify-center items-center">
          <AddBannerDialogue
            isEditing={isEditing}
            editingBanner={editingBanner}
            setIsEditing={setIsEditing}
            setBanners={setBanners}
            setAddBannerAlert={setAddBannerAlert}
          />
        </div>
      )}

      {addProductsDialogue && (
        <div className=" flex absolute z-50 left-0 w-screen h-screen bg-blue-light bg-opacity-0 backdrop-filter backdrop-blur-sm justify-center items-center">
          <AddProductsDialogue
            setBanners={setBanners}
            currentBanner={currentBanner}
            products={products}
            setAddProductsDialogue={setAddProductsDialogue}
          />
        </div>
      )}
      <TopBar></TopBar>
      <div className="flex-col h-full w-full items-center px-8 mt-2">
        <div className="flex items-center justify-between">
          <span className="text-black font-semibold text-xl">Top Banners</span>
          <div
            onClick={handleAdd}
            className="flex relative h-12 bg-customYellow-light shadow-sm border-none ml-4 w-40 rounded-xl  items-center justify-center cursor-pointer transform hover:scale-95  transition duration-500 ease-in-out"
          >
            <span className="font-semibold text-sm text-white">Add Banner</span>
          </div>
        </div>
        {isLoading ? (
          <div className="flex w-full h-screen items-center justify-center bg-white">
            <Loader type="Puff" color="#00BFFF" height={50} width={50} />
          </div>
        ) : banners.length === 0 ? (
          <div className="flex items-center justify-center mt-20">
            <span className="text-gray-400 font-semibold">No Banners</span>
          </div>
        ) : (
          <div className="flex-col mt-10">
            {/* General Banners */}
            {generalBanners.length !== 0 && (
              <div className="flex-col">
                <span className="text-black text-md tracking-wide font-semibold">
                  Generals
                </span>
                {generalBanners.length === 0 ? (
                  <div className="flex items-center justify-center my-4">
                    <span className="text-gray-400 font-semibold">
                      No General Banners
                    </span>
                  </div>
                ) : (
                  <Accordion
                    className="h-auto flex-col pt-3 items-start mb-6"
                    isHovered={true}
                  >
                    {generalBanners.map((banner) => {
                      return (
                        <AccordionItem
                          key={banner._id}
                          className="mb-4"
                          onExpand={() => setIsTileOpen(true)}
                          onClose={() => setIsTileOpen(false)}
                          title={
                            <div className="flex h-16 items-center bg-bgColor-light border-none px-4 rounded-2xl shadow-sm justify-between justify-items-center cursor-pointer hover:shadow-md">
                              <div className="flex items-center justify-center">
                                <img
                                  className="h-10 w-10 rounded-2xl mr-6 ml-4 object-contain"
                                  src={banner.image}
                                  alt=""
                                />
                              </div>
                              <span className="text-black font-semibold mr-4">
                                {banner.type}
                              </span>

                              <div className="flex items-center">
                                <span className="text-black font-semibold mr-4">
                                  Status
                                </span>
                                <Status banner={banner} />
                              </div>

                              <div className="flex items-center">
                                <div className="flex items-end mr-6">
                                  <EditIcon
                                    onClick={(e) => handleEdit(e, banner)}
                                    className="mr-3 h-5 w-5 cursor-pointer fill-lightGreen hover:fill-green"
                                  />
                                  <DeleteIcon
                                    onClick={(e) =>
                                      handleBannerDelete(e, banner)
                                    }
                                    className="cursor-pointer h-5 w-5 fill-lightRed hover:fill-red"
                                  />
                                </div>
                              </div>
                            </div>
                          }
                          expanded={banner === 1}
                        ></AccordionItem>
                      );
                    })}
                  </Accordion>
                )}
              </div>
            )}

            {/* Sale Banners */}

            {saleBanners.length !== 0 && (
              <div className="flex-col">
                <span className="text-black text-md tracking-wide font-semibold">
                  Sale
                </span>
                {saleBanners.length === 0 ? (
                  <div className="flex items-center justify-center my-4">
                    <span className="text-gray-400 font-semibold">
                      No Sale Banners
                    </span>
                  </div>
                ) : (
                  <Accordion
                    className="h-auto flex-col pt-3  items-start mb-6 "
                    isHovered={true}
                  >
                    {saleBanners.map((banner) => {
                      return (
                        <AccordionItem
                          key={banner._id}
                          className="mb-4"
                          onExpand={() => setIsTileOpen(true)}
                          onClose={() => setIsTileOpen(false)}
                          title={
                            <div
                              className={`flex h-16 items-center bg-bgColor-light border-none px-4 ${
                                !isTileOpen ? "rounded-2xl" : "rounded-t-2xl"
                              }  shadow-sm justify-between justify-items-center cursor-pointer hover:shadow-md`}
                            >
                              <div className="flex items-center justify-center">
                                <img
                                  className="h-20 w-20 rounded-2xl mr-6 ml-4 object-contain"
                                  src={banner.image}
                                  alt=""
                                />
                              </div>
                              <span className="text-black font-semibold mr-4">
                                {banner.type}
                              </span>

                              <div className="flex items-center">
                                <span className="text-black font-semibold mr-4">
                                  Status
                                </span>
                                <Status banner={banner} />
                              </div>

                              <div
                                onClick={(e) => handleAddProducts(e, banner)}
                                className="flex items-center justify-center h-8 w-28 rounded-xl bg-darkBlue-light cursor-pointer transform hover:scale-95  transition duration-500 ease-in-out"
                              >
                                <span className="text-white font-semibold text-sm">
                                  Add Product
                                </span>
                              </div>

                              <div className="flex items-center">
                                <div className="flex items-end mr-6">
                                  <EditIcon
                                    onClick={(e) => handleEdit(e, banner)}
                                    className="mr-3 h-5 w-5 cursor-pointer fill-lightGreen hover:fill-green"
                                  />
                                  <DeleteIcon
                                    onClick={(e) =>
                                      handleBannerDelete(e, banner)
                                    }
                                    className="cursor-pointer h-5 w-5 fill-lightRed hover:fill-red"
                                  />
                                </div>
                                {isTileOpen ? (
                                  <ChevronUpIcon className="h-6 w-6 relative text-black cursor-pointer"></ChevronUpIcon>
                                ) : (
                                  <ChevronDownIcon className="h-6 w-6 relative text-black cursor-pointer"></ChevronDownIcon>
                                )}
                              </div>
                            </div>
                          }
                          expanded={banner === 1}
                        >
                          <div className="flex flex-wrap h-auto bg-bgColor-light bg-opacity-50 w-full p-6">
                            {banner.products.length === 0 ? (
                              <span className="text-gray-400 font-semibold">
                                No Products
                              </span>
                            ) : (
                              banner.products.map((item, index) => (
                                <div
                                  key={index}
                                  className="flex w-80 h-16 mr-8 mb-6  bg-blue-light bg-opacity-30 rounded-2xl items-center justify-between px-6 shadow-sm"
                                >
                                  <div className="flex items-center">
                                    <img
                                      className="h-8 w-8 rounded-full mr-2"
                                      src={item.thumbnail}
                                      alt=""
                                    />
                                    <span className="text-black font-semibold capitalize mr-4">
                                      {item.name}
                                    </span>
                                    <span className="text-green-400 font-semibold capitalize">
                                      {`${item.discount}% OFF`}
                                    </span>
                                  </div>
                                  <div className="flex">
                                    <DeleteIcon
                                      onClick={(e) =>
                                        handleProductDelete(
                                          e,
                                          banner._id,
                                          item._id,
                                          item.price
                                        )
                                      }
                                      className="cursor-pointer h-5 w-5 fill-grey hover:fill-red"
                                    />
                                  </div>
                                </div>
                              ))
                            )}
                          </div>
                        </AccordionItem>
                      );
                    })}
                  </Accordion>
                )}
              </div>
            )}
          </div>
        )}
      </div>
    </div>
  );
};

export default Banners;

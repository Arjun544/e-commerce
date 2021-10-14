import React, { useState, useEffect, useContext } from "react";
import TopBar from "../../components/TopBar";
import Switch from "react-switch";
import { useForm } from "react-hook-form";
import { useSnackbar } from "notistack";
import { useHistory } from "react-router-dom";
import CustomEditor from "./components/CustomEditor";
import { getCategories } from "../../api/categoriesApi";
import Loader from "react-loader-spinner";
import CategoriesDropDown from "./components/CategoriesDropDown";
import SubCategoriesDropDown from "./components/SubCategoriesDropDown";
import { FilePond, registerPlugin } from "react-filepond";
import FilePondPluginFileValidateType from "filepond-plugin-file-validate-type";
import FilePondPluginImageExifOrientation from "filepond-plugin-image-exif-orientation";
import FilePondPluginImagePreview from "filepond-plugin-image-preview";
import FilePondPluginFileEncode from "filepond-plugin-file-encode";
import ReactTooltip from "react-tooltip";
import CustomButon from "../../components/custom_button";
import { addProduct, uploadMultiImages } from "../../api/productsApi";
import { AppContext } from "../../App";

// Register the plugins
registerPlugin(
  FilePondPluginImageExifOrientation,
  FilePondPluginImagePreview,
  FilePondPluginFileValidateType,
  FilePondPluginFileEncode
);

const AddProduct = () => {
  const { isBigScreen } = useContext(AppContext);
  const history = useHistory();
  const [loading, setLoading] = useState(false);
  const { enqueueSnackbar, closeSnackbar } = useSnackbar();
  const [categories, setCategories] = useState([]);
  const [thumbnail, setThumbnail] = useState("");
  const [images, setImages] = useState([]);
  const [isFeatured, setIsFeatured] = useState(false);
  const [isOnSale, setIsOnSale] = useState(false);
  const [subCategories, setSubCategories] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const [isEditing, setIsEditing] = useState(false);
  const [selectedCategoryId, setSelectedCategoryId] = useState("");
  const [selectedCategory, setSelectedCategory] = useState(0);
  const [currentSubCategory, setCurrentSubCategory] = useState(
    "Select Sub Category"
  );

  const [input, setInput] = useState("");
  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm();

  useEffect(() => {
    const fetchCategories = async () => {
      try {
        setIsLoading(true);
        const { data } = await getCategories();
        setCategories(data.categoryList);
        setIsLoading(false);
      } catch (error) {
        setIsLoading(false);
        console.log(error.response);
      }
    };
    fetchCategories();
  }, []);

  const handleAddProduct = async (data) => {
    if (thumbnail.length < 1) {
      return enqueueSnackbar("Thumbnail is required", {
        variant: "warning",
        autoHideDuration: 2000,
      });
    } else if (thumbnail.length > 1) {
      return enqueueSnackbar("Thumbnail can't greater than 1", {
        variant: "warning",
        autoHideDuration: 2000,
      });
    } else if (images.length < 1) {
      return enqueueSnackbar("Images are required", {
        variant: "warning",
        autoHideDuration: 2000,
      });
    } else if (thumbnail.length > 4) {
      return enqueueSnackbar("Thumbnail can't greater than 4", {
        variant: "warning",
        autoHideDuration: 2000,
      });
    } else if (!input) {
      return enqueueSnackbar("Full description is required", {
        variant: "warning",
        autoHideDuration: 2000,
      });
    } else if (currentSubCategory === "Select Sub Category") {
      return enqueueSnackbar("Please select sub category", {
        variant: "warning",
        autoHideDuration: 2000,
      });
    } else {
      try {
        setLoading(true);
        const product = await addProduct(
          data.name,
          data.description,
          input,
          selectedCategoryId,
          data.stock,
          isFeatured,
          data.price,
          thumbnail[0].getFileEncodeDataURL(),
          currentSubCategory,
          isOnSale,
          data.discount === undefined ? 0 : data.discount
        );
        await uploadMultiImages(
          product.data.product.id,
          images.map((item) => item.getFileEncodeDataURL())
        );
        history.push("/products");
        setLoading(false);
        enqueueSnackbar("Product has been added", {
          variant: "success",
          autoHideDuration: 2000,
        });
      } catch (error) {
        enqueueSnackbar(error.response.data.message, {
          variant: "error",
          autoHideDuration: 2000,
        });
      } finally {
        setLoading(false);
      }
    }
  };

  return (
    <div className="flex flex-col w-full h-full mt-30 overflow-y-auto overflow-x-hidden  bg-white">
      <TopBar />
      {isLoading ? (
        <div className="flex w-full h-screen items-center justify-center bg-white">
          <Loader
            type="Puff"
            color="#00BFFF"
            height={50}
            width={50}
            timeout={3000} //3 secs
          />
        </div>
      ) : (
        <div className="flex flex-col h-full px-10 mt-6">
          <span className="text-black font-semibold text-xl">Add Product</span>
          <div className="flex h-full">
            <div className="flex flex-col flex-grow bg-white pr-10">
              {/* Name */}
              <div className="flex flex-col mb-4">
                <input
                  className="h-14 w-1/2 mt-6 rounded-2xl font-semibold text-black bg-bgColor-light pl-4 mb-2 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent "
                  placeholder="Name"
                  maxLength="50"
                  {...register("name", {
                    required: true,
                    minLength: 2,
                    maxLength: 50,
                  })}
                />
                {errors?.name?.type === "required" && (
                  <span className="flex text-red-500 text-xs font-semibold">
                    Name is required
                  </span>
                )}
                {errors?.name?.type === "minLength" && (
                  <span className="flex text-red-500 text-xs font-semibold">
                    Name can't be less than 2 characters
                  </span>
                )}
                {errors?.name?.type === "maxLength" && (
                  <span className="flex text-red-500 text-xs font-semibold">
                    Name must have at least 2 characters
                  </span>
                )}
              </div>
              {/* Desc */}
              <div className="flex flex-col mb-4">
                <input
                  className="h-14 w-1/2 rounded-2xl text-black font-semibold bg-bgColor-light pl-4 mb-2 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent "
                  placeholder="Description"
                  maxLength="100"
                  {...register("description", {
                    required: true,
                    maxLength: 100,
                    minLength: 2,
                  })}
                />
                {errors?.description?.type === "required" && (
                  <span className="flex text-red-500 text-xs font-semibold">
                    Description is required
                  </span>
                )}
                {errors?.description?.type === "minLength" && (
                  <span className="flex text-red-500 text-xs font-semibold">
                    Description can't be less than 2 characters
                  </span>
                )}
                {errors?.description?.type === "maxLength" && (
                  <span className="flex text-red-500 text-xs font-semibold">
                    Description can't be more than 50 characters
                  </span>
                )}
              </div>
              <div className="bg-bgColor-light text-black font-semibold rounded-2xl mb-2">
                <CustomEditor input={input} setInput={setInput} />
              </div>
              {!input && (
                <span className="flex text-red-500 text-xs font-semibold">
                  Full description is required
                </span>
              )}
              <div className="flex mt-6">
                {/* Price */}
                <div className="flex flex-col w-1/2 mb-4">
                  <input
                    className="h-14  mr-6 rounded-xl font-semibold text-black bg-bgColor-light px-4 mb-2 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent "
                    placeholder="Price"
                    type="number"
                    min="0"
                    max="9999"
                    {...register("price", {
                      required: true,
                      minLength: 1,
                      maxLength: 9999,
                    })}
                  />
                  {errors?.price?.type === "required" && (
                    <span className="flex text-red-500 text-xs font-semibold">
                      Price is required
                    </span>
                  )}
                  {errors?.price?.type === "minLength" && (
                    <span className="flex  text-red-500 text-xs font-semibold">
                      Price can't be empty
                    </span>
                  )}
                  {errors?.price?.type === "maxLength" && (
                    <span className="flex text-red-500 text-xs font-semibold">
                      Price can't be greather than 9999
                    </span>
                  )}
                </div>
                {/* Stock */}
                <div className="flex flex-col mb-4 w-1/2">
                  <input
                    className="h-14  rounded-xl font-semibold text-black bg-bgColor-light px-4 mb-2 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent "
                    placeholder="Stock"
                    type="number"
                    min="0"
                    {...register("stock", {
                      required: true,
                      minLength: 1,
                    })}
                  />
                  {errors?.stock?.type === "required" && (
                    <span className="flex text-red-500 text-xs font-semibold">
                      In Stock is required
                    </span>
                  )}
                  {errors?.stock?.type === "minLength" && (
                    <span className="flex text-red-500 text-xs font-semibold">
                      In stock can't be empty
                    </span>
                  )}
                </div>
              </div>
              {/* categories */}
              <div className="flex mb-6 w-full">
                <CategoriesDropDown
                  subCategories={subCategories}
                  isEditing={isEditing}
                  categories={categories}
                  setSubCategories={setSubCategories}
                  setSelectedCategory={setSelectedCategory}
                  setSelectedCategoryId={setSelectedCategoryId}
                  setCurrentSubCategory={setCurrentSubCategory}
                />
                <div className="flex flex-col w-full">
                  <SubCategoriesDropDown
                    isEditing={isEditing}
                    subCategories={subCategories[selectedCategory]}
                    currentSubCategory={currentSubCategory}
                    setCurrentSubCategory={setCurrentSubCategory}
                  />
                  {currentSubCategory === "Select Sub Category" && (
                    <span className="flex -ml-9 text-red-500 text-xs font-semibold mt-2">
                      Please select sub category
                    </span>
                  )}
                </div>
              </div>
              {/* Images */}
              <div className="flex-col">
                <div className="flex">
                  <span className="font-semibold text-gray-400 tracking-wide mr-2">
                    Upload images
                  </span>
                  <div
                    data-tip="Use images with transparent background for better results"
                    className="h-5 w-5 rounded-md bg-Grey-dark flex items-center justify-center cursor-pointer"
                  >
                    <span className="font-semibold text-sm text-white tracking-wide">
                      !
                    </span>
                  </div>
                </div>

                {images.length < 1 && (
                  <span className="flex mb-2 text-red-500 text-xs font-semibold">
                    Images are required
                  </span>
                )}
                {images.length < 4 && (
                  <span className="flex mb-2 text-red-500 text-xs font-semibold">
                    Images can't be less than 4
                  </span>
                )}
                {images.length > 4 && (
                  <span className="flex mb-2 text-red-500 text-xs font-semibold">
                    Images can't be greater than 4
                  </span>
                )}
              </div>
              <div className="mt-4">
                <FilePond
                  files={images}
                  allowReorder={true}
                  allowMultiple={true}
                  onupdatefiles={setImages}
                  allowFileTypeValidation={true}
                  allowFileEncode={true}
                  acceptedFileTypes={["image/png", "image/jpeg"]}
                  labelIdle={`${
                    images === "" && isEditing
                      ? "<span class=filepond--label-action text-green-500 no-underline>Update new</span> "
                      : "Drag & Drop images or <span class=filepond--label-action text-green-500 no-underline>Browse</span>"
                  } `}
                />
              </div>
              <div className="flex items-center justify-center mt-8 pb-10">
                {loading ? (
                  <div className="flex items-center justify-center">
                    <Loader
                      type="Puff"
                      color="#00BFFF"
                      height={50}
                      width={50}
                    />
                  </div>
                ) : (
                  <CustomButon
                    text={"Add Product"}
                    color={"bg-darkBlue-light"}
                    width={72}
                    onPressed={handleSubmit((data) => handleAddProduct(data))}
                  ></CustomButon>
                )}
              </div>
            </div>
            {/* Right info */}
            <div className="flex-col flex-grow-0 w-1/4 bg-white">
              {/* Thumbnail */}
              <div className="flex-col">
                <div className="flex">
                  <span className="font-semibold text-gray-400 tracking-wide mr-2">
                    Thumbnail
                  </span>
                  <div
                    data-tip="Use image with transparent background for better results"
                    className="h-5 w-5 rounded-md bg-Grey-dark flex items-center justify-center cursor-pointer"
                  >
                    <span className="font-semibold text-sm text-white tracking-wide">
                      !
                    </span>
                  </div>
                </div>

                {thumbnail.length < 1 && (
                  <span className="flex mb-2 text-red-500 text-xs font-semibold">
                    Thumbnail is required
                  </span>
                )}
                {thumbnail.length > 1 && (
                  <span className="flex mb-2 text-red-500 text-xs font-semibold">
                    Thumbnail can't be greater than 1
                  </span>
                )}
              </div>

              <ReactTooltip
                place="top"
                type="info"
                effect="float"
                offset={{ top: 5 }}
              />

              <div className="mt-4">
                <FilePond
                  files={thumbnail}
                  allowReorder={false}
                  allowMultiple={false}
                  onupdatefiles={setThumbnail}
                  allowFileTypeValidation={true}
                  allowFileEncode={true}
                  acceptedFileTypes={["image/png", "image/jpeg"]}
                  labelIdle={`${
                    thumbnail === "" && isEditing
                      ? "<span class=filepond--label-action text-green-500 no-underline>Update new</span> "
                      : "Drag & Drop thumbnail or <span class=filepond--label-action text-green-500 no-underline>Browse</span>"
                  } `}
                />
              </div>
              {/* IsFeatured */}
              <div className="flex mt-14 items-center">
                <span className="font-semibold text-gray-400 tracking-wide mr-6">
                  Featured
                </span>
                <Switch
                  value={isFeatured}
                  checked={isFeatured}
                  onChange={(e) => setIsFeatured((preState) => !preState)}
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
              </div>
              {/* OnSale */}
              <div className="flex mt-6 items-center">
                <span className="font-semibold text-gray-400 tracking-wide mr-9">
                  On Sale
                </span>
                <Switch
                  value={isOnSale}
                  checked={isOnSale}
                  onChange={(e) => setIsOnSale((preState) => !preState)}
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
              </div>
              {isOnSale && (
                <div className="flex flex-col mt-4">
                  <input
                    className="h-14 w-full rounded-xl font-semibold text-black bg-bgColor-light px-4 mb-2 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent "
                    placeholder="Discount in %"
                    type="number"
                    min="0"
                    {...register("discount", {
                      required: true,
                      minLength: 0,
                    })}
                  />
                  {errors?.discount?.type === "required" && (
                    <span className="flex text-red-500 text-xs font-semibold">
                      Discount is required
                    </span>
                  )}
                  {errors?.discount?.type === "minLength" && (
                    <span className="flex  text-red-500 text-xs">
                      Discount can't be less than 0
                    </span>
                  )}
                </div>
              )}
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default AddProduct;

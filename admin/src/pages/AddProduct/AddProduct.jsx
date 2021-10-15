import React, { useState, useEffect } from "react";
import TopBar from "../../components/TopBar";
import Switch from "react-switch";
import { useForm } from "react-hook-form";
import { useSnackbar } from "notistack";
import { useHistory, useParams } from "react-router-dom";
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
import {
  addProduct,
  uploadMultiImages,
  getProductById,
} from "../../api/productsApi";

// Register the plugins
registerPlugin(
  FilePondPluginImageExifOrientation,
  FilePondPluginImagePreview,
  FilePondPluginFileValidateType,
  FilePondPluginFileEncode
);

const AddProduct = ({ isEditing }) => {
  const history = useHistory();
  const params = useParams();
  const [loading, setLoading] = useState(false);
  const { enqueueSnackbar, closeSnackbar } = useSnackbar();
  const [categories, setCategories] = useState([]);
  const [editingProduct, setEditingProduct] = useState([]);
  const [editingCategoryName, setEditingCategoryName] = useState("");
  const [editingCategoryId, setEditingCategoryId] = useState("");
  const [editingSubCategoryName, setEditingSubCategoryName] = useState("");
  const [thumbnail, setThumbnail] = useState("");
  const [images, setImages] = useState([]);
  const [isFeatured, setIsFeatured] = useState(false);
  const [isOnSale, setIsOnSale] = useState(false);
  const [subCategories, setSubCategories] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
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
    const fetchEditingProduct = async () => {
      try {
        setIsLoading(true);
        const { data } = await getProductById(params.id);
        setEditingProduct(data.products);
        setThumbnail(data.products.thumbnail);
        setIsFeatured(data.products.isFeatured);
        setIsOnSale(data.products.onSale);
        setEditingCategoryName(data.products.category.name);
        setEditingCategoryId(data.products.category._id);
        setEditingSubCategoryName(data.products.subCategory);
        setIsLoading(false);
      } catch (error) {
        setIsLoading(false);
        console.log(error.response);
      }
    };
    if (isEditing) {
      fetchEditingProduct();
    }
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
          <span className="text-black font-semibold text-xl">
            {isEditing ? "Edit Product" : "Add Product"}
          </span>
          <div className=" flex-col flex-grow bg-white">
            <div className="flex w-full items-center">
              <div className="flex-col w-1/2">
                {/* Name */}
                <div className="flex-col mb-4">
                  <input
                    className="h-14 w-full mt-6 rounded-2xl font-semibold text-black bg-bgColor-light pl-4 mb-2 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent "
                    placeholder={isEditing ? editingProduct.name : "Name"}
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
                <div className="flex-col mb-4">
                  <input
                    className="h-14 w-full rounded-2xl text-black font-semibold bg-bgColor-light pl-4 mb-2 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent "
                    placeholder={
                      isEditing ? editingProduct.description : "Description"
                    }
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
              </div>
              {/* Thumbnail */}
              <div className="flex-col flex-grow ml-12">
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
                      isEditing
                        ? "<span class=filepond--label-action text-green-500 no-underline>Update new</span> "
                        : "Drag & Drop thumbnail or <span class=filepond--label-action text-green-500 no-underline>Browse</span>"
                    } `}
                  />
                </div>
              </div>
            </div>
            <div className="bg-bgColor-light text-black font-semibold rounded-2xl mb-2">
              <CustomEditor
                input={isEditing ? editingProduct.fullDescription : input}
                setInput={setInput}
              />
            </div>
            {!input && (
              <span className="flex text-red-500 text-xs font-semibold">
                Full description is required
              </span>
            )}
            <div className="flex items-center mb-4 mt-8">
              {/* IsFeatured */}
              <div className="flex  mr-20 items-center">
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
              <div className="flex items-center mr-8">
                <span className="font-semibold text-gray-400 tracking-wide mr-6">
                  OnSale
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
                <div className="flex flex-col w-full">
                  <input
                    className="h-14 w-full rounded-xl font-semibold text-black bg-bgColor-light px-4 mb-2 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent "
                    placeholder={
                      isEditing ? editingProduct.discount : "Discount in %"
                    }
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
            <div className="flex mt-6 flex-grow">
              {/* Price */}
              <div className=" flex-col w-full mb-4">
                <input
                  className="h-14 w-full  mr-6 rounded-xl font-semibold text-black bg-bgColor-light px-4 mb-2 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent "
                  placeholder={isEditing ? editingProduct.price : "Price"}
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
              <div className="w-12"></div>
              {/* Stock */}
              <div className="flex flex-col mb-4 w-full">
                <input
                  className="h-14 w-full rounded-xl font-semibold text-black bg-bgColor-light px-4 mb-2 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent "
                  placeholder={
                    isEditing ? editingProduct.countInStock : "Stock"
                  }
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
            <div className="flex mb-6 flex-grow">
              <CategoriesDropDown
                subCategories={subCategories}
                isEditing={isEditing}
                editingCategoryName={editingCategoryName}
                categories={categories}
                selectedCategory={selectedCategory}
                editingCategoryId={editingCategoryId}
                setSubCategories={setSubCategories}
                setSelectedCategory={setSelectedCategory}
                setSelectedCategoryId={setSelectedCategoryId}
                setCurrentSubCategory={setCurrentSubCategory}
              />
              <div className="w-12"></div>
              <div className="flex-col w-full">
                <SubCategoriesDropDown
                  isEditing={isEditing}
                  categories={categories}
                  editingSubCategoryName={editingSubCategoryName}
                  subCategories={
                    isEditing ? subCategories : subCategories[selectedCategory]
                  }
                  setSubCategories={setSubCategories}
                  selectedCategory={selectedCategory}
                  editingCategoryId={editingCategoryId}
                  // subCategories={
                  //   categories.filter(
                  //     (item) => item._id === editingCategoryId
                  //   )[0].subCategories
                  // }
                  currentSubCategory={currentSubCategory}
                  setCurrentSubCategory={setCurrentSubCategory}
                />
                {currentSubCategory === "Select Sub Category" && (
                  <span className="flex ml-3 text-red-500 text-xs font-semibold mt-2">
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
                  <Loader type="Puff" color="#00BFFF" height={50} width={50} />
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
        </div>
      )}
    </div>
  );
};

export default AddProduct;

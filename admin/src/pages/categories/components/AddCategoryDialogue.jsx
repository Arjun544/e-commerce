import React, { useState, useEffect, useContext } from "react";
import FilePondPluginFileValidateType from "filepond-plugin-file-validate-type";
import FilePondPluginImageExifOrientation from "filepond-plugin-image-exif-orientation";
import FilePondPluginImagePreview from "filepond-plugin-image-preview";
import FilePondPluginFileEncode from "filepond-plugin-file-encode";
import "filepond-plugin-image-preview/dist/filepond-plugin-image-preview.css";
import { useSnackbar } from "notistack";
import { Puff } from "react-loader-spinner";

import { FilePond, registerPlugin } from "react-filepond";
import "filepond/dist/filepond.min.css";
import { addCategory, updateCategory } from "../../../api/categoriesApi";
import { AppContext } from "../../../App";

// Register the plugins
registerPlugin(
  FilePondPluginImageExifOrientation,
  FilePondPluginImagePreview,
  FilePondPluginFileValidateType,
  FilePondPluginFileEncode
);

const AddCategoryDialogue = ({
  isAddCategoryEditing,
  editingCategory,
  setIsAddCategoryEditing,
  setCategories,
  categoryAlert,
  setAddCategoryAlert,
  addCategoryAlert,
  addCategoryInput,
  setAddCategoryInput,
}) => {
  const { socket } = useContext(AppContext);
  const { enqueueSnackbar } = useSnackbar();
  const [file, setFile] = useState("");
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    if (isAddCategoryEditing) {
      setAddCategoryInput(editingCategory.name);
      setFile(editingCategory.icon);
    }
  }, [editingCategory, isAddCategoryEditing, setAddCategoryInput]);

  const handleAdd = async (e) => {
    e.preventDefault();
    if (addCategoryAlert.length <= 2 || file === "") {
      enqueueSnackbar("Fields can't be empty", {
        variant: "error",
        autoHideDuration: 2000,
      });
    } else {
      try {
        setLoading(true);
        await addCategory(addCategoryInput, file[0].getFileEncodeDataURL());
        setLoading(false);
        setAddCategoryAlert(false);
        socket.current.on("add-category", (newCategories) => {
          setCategories(newCategories);
        });
        setAddCategoryInput("");
        setIsAddCategoryEditing(false);
        enqueueSnackbar("Category added", {
          variant: "success",
          autoHideDuration: 2000,
        });
      } catch (error) {
        enqueueSnackbar(error.response.data.message, {
          variant: "error",
          autoHideDuration: 2000,
        });
        setLoading(false);
        setAddCategoryInput("");
        setIsAddCategoryEditing(false);
      }
    }
  };

  const handleEdit = async (e) => {
    e.preventDefault();
    if (addCategoryInput.length <= 2 || file === "") {
      enqueueSnackbar("Fields can't be empty", {
        variant: "error",
        autoHideDuration: 2000,
      });
    } else {
      try {
        setLoading(true);
        await updateCategory(
          editingCategory.id,
          addCategoryInput,
          file[0].getFileEncodeDataURL(),
          editingCategory.iconId
        );
        setLoading(false);
        setAddCategoryAlert(false);
        socket.current.on("edit-category", (newCategories) => {
          setCategories(newCategories);
        });
        setAddCategoryInput("");
        setIsAddCategoryEditing(false);
        enqueueSnackbar("Category updated", {
          variant: "success",
          autoHideDuration: 2000,
        });
      } catch (error) {
        enqueueSnackbar(error.response.data.message, {
          variant: "error",
          autoHideDuration: 2000,
        });
        setLoading(false);
        setAddCategoryInput("");
        setIsAddCategoryEditing(false);
      }
    }
  };

  return (
    <div className="flex flex-col py-10 w-1/3 rounded-3xl bg-blue-light justify-center px-16">
      <div className="flex items-center justify-center">
        <span className="text-black font-semibold tracking-wider mb-8">
          {isAddCategoryEditing ? "Edit Category" : "Add Category"}
        </span>
      </div>
      <div className="flex items-center justify-center">
        <input
          className="h-14 w-full rounded-2xl text-black bg-bgColor-light pl-4 mb-4 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent "
          placeholder={isAddCategoryEditing ? editingCategory.name : "Name"}
          type="text"
          value={addCategoryInput}
          onChange={(e) => {
            setAddCategoryInput(e.target.value);
          }}
        />
      </div>
      <FilePond
        files={file}
        allowReorder={false}
        allowMultiple={false}
        onupdatefiles={setFile}
        allowFileTypeValidation={true}
        allowFileEncode={true}
        acceptedFileTypes={["image/png", "image/jpeg"]}
        labelIdle={`${
          file === "" && isAddCategoryEditing
            ? "<span class=filepond--label-action text-green-500 no-underline>Update new</span> "
            : "Drag & Drop category icon or <span class=filepond--label-action text-green-500 no-underline>Browse</span>"
        } `}
      />

      <div className="flex items-center justify-center mt-6">
        <div
          onClick={(e) => {
            e.preventDefault();
            setAddCategoryAlert(false);
            setAddCategoryInput("");
            setIsAddCategoryEditing(false);
          }}
          className="flex h-12 bg-red-500  shadow-sm border-none ml-4 w-32 rounded-xl  items-center justify-center cursor-pointer transform hover:scale-95  transition duration-500 ease-in-out"
        >
          <span className="font-semibold text-sm text-white">Cancel</span>
        </div>
        {loading ? (
          <div className="flex items-center justify-center ml-2">
            <Puff color="#00BFFF" height={50} width={50} />
          </div>
        ) : (
          <div
            onClick={isAddCategoryEditing ? handleEdit : handleAdd}
            className="flex h-12 bg-green-500  shadow-sm border-none ml-4 w-32 rounded-xl  items-center justify-center cursor-pointer transform hover:scale-95  transition duration-500 ease-in-out"
          >
            <span className="font-semibold text-sm text-white">
              {isAddCategoryEditing ? "Edit" : "Add"}
            </span>
          </div>
        )}
      </div>
    </div>
  );
};

export default AddCategoryDialogue;

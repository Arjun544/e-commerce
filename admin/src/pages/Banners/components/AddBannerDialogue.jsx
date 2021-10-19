import React, { useState, useEffect, useContext } from "react";
import FilePondPluginFileValidateType from "filepond-plugin-file-validate-type";
import FilePondPluginImageExifOrientation from "filepond-plugin-image-exif-orientation";
import FilePondPluginImagePreview from "filepond-plugin-image-preview";
import FilePondPluginFileEncode from "filepond-plugin-file-encode";
import "filepond-plugin-image-preview/dist/filepond-plugin-image-preview.css";
import { useSnackbar } from "notistack";
import Loader from "react-loader-spinner";

import { FilePond, registerPlugin } from "react-filepond";
import "filepond/dist/filepond.min.css";
import { AppContext } from "../../../App";
import { addBanner, updateBanner } from "../../../api/bannersApi";
import TypesDropDown from "./TypesDropDown";

// Register the plugins
registerPlugin(
  FilePondPluginImageExifOrientation,
  FilePondPluginImagePreview,
  FilePondPluginFileValidateType,
  FilePondPluginFileEncode
);

const AddBannerDialogue = ({
  isEditing,
  editingBanner,
  setIsEditing,
  setBanners,
  setAddBannerAlert,
  input,
  setInput,
}) => {
  const { socket } = useContext(AppContext);
  const { enqueueSnackbar, closeSnackbar } = useSnackbar();
  const [file, setFile] = useState("");
  const [loading, setLoading] = useState(false);
  const [selectedType, setSelectedType] = useState("Select type");

  useEffect(() => {
    if (isEditing) {
      setInput(editingBanner.title);
      setSelectedType(editingBanner.type);
      setFile(editingBanner.image);
    }
  }, []);

  const handleAdd = async (e) => {
    e.preventDefault();
    if (input.length === 0 || file === "") {
      enqueueSnackbar("Fields can't be empty", {
        variant: "error",
        autoHideDuration: 2000,
      });
    } else if (selectedType === "Select type") {
      enqueueSnackbar("Please select type", {
        variant: "error",
        autoHideDuration: 2000,
      });
    } else {
      try {
        setLoading(true);
        await addBanner(input, file[0].getFileEncodeDataURL(), selectedType, []);
        setLoading(false);
        setAddBannerAlert(false);
        socket.current.on("add-banner", (newBanners) => {
          setBanners(newBanners);
        });
        setInput("");
        setIsEditing(false);
        enqueueSnackbar("Banner added", {
          variant: "success",
          autoHideDuration: 2000,
        });
      } catch (error) {
        enqueueSnackbar(error.response.data.message, {
          variant: "error",
          autoHideDuration: 2000,
        });
        setLoading(false);
        setInput("");
        setIsEditing(false);
      }
    }
  };

  const handleEdit = async (e) => {
    e.preventDefault();
    if (input.length === 0 || file === "") {
      enqueueSnackbar("Fields can't be empty", {
        variant: "error",
        autoHideDuration: 2000,
      });
    } else {
      try {
        setLoading(true);
        await updateBanner(
          editingBanner._id,
          input,
          file[0].getFileEncodeDataURL(),
          editingBanner.imageId,
        );
        setLoading(false);
        setAddBannerAlert(false);
        socket.current.on("edit-banner", (newBanners) => {
          setBanners(newBanners);
        });
        setInput("");
        setIsEditing(false);
        enqueueSnackbar("Banner updated", {
          variant: "success",
          autoHideDuration: 2000,
        });
      } catch (error) {
        enqueueSnackbar(error.response.data.message, {
          variant: "error",
          autoHideDuration: 2000,
        });
        setLoading(false);
        setInput("");
        setIsEditing(false);
      }
    }
  };

  return (
    <div className="flex flex-col py-10 w-1/3 rounded-3xl bg-blue-light justify-center px-16">
      <div className="flex items-center justify-center">
        <span className="text-black font-semibold tracking-wider mb-8">
          {isEditing ? "Edit Banner" : "Add Banner"}
        </span>
      </div>
      <div className="flex items-center justify-center">
        <input
          className="h-14 w-full rounded-2xl text-black bg-bgColor-light pl-4 mb-4 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent "
          placeholder={isEditing ? editingBanner.name : "Title"}
          type="text"
          value={input}
          onChange={(e) => {
            setInput(e.target.value);
          }}
        />
      </div>
      <TypesDropDown  selectedType={selectedType} setSelectedType={setSelectedType} ></TypesDropDown>
      <FilePond
        files={file}
        allowReorder={false}
        allowMultiple={false}
        onupdatefiles={setFile}
        allowFileTypeValidation={true}
        allowFileEncode={true}
        acceptedFileTypes={["image/png", "image/jpeg"]}
        labelIdle={`${
          file === "" && isEditing
            ? "<span class=filepond--label-action text-green-500 no-underline>Update new</span> "
            : "Drag & Drop banner icon or <span class=filepond--label-action text-green-500 no-underline>Browse</span>"
        } `}
      />

      <div className="flex items-center justify-center mt-6">
        <div
          onClick={(e) => {
            e.preventDefault();
            setAddBannerAlert(false);
            setInput("");
            setIsEditing(false);
          }}
          className="flex h-12 bg-red-500  shadow-sm border-none ml-4 w-32 rounded-xl  items-center justify-center cursor-pointer transform hover:scale-95  transition duration-500 ease-in-out"
        >
          <span className="font-semibold text-sm text-white">Cancel</span>
        </div>
        {loading ? (
          <div className="flex items-center justify-center ml-2">
            <Loader type="Puff" color="#00BFFF" height={50} width={50} />
          </div>
        ) : (
          <div
            onClick={isEditing ? handleEdit : handleAdd}
            className="flex h-12 bg-green-500  shadow-sm border-none ml-4 w-32 rounded-xl  items-center justify-center cursor-pointer transform hover:scale-95  transition duration-500 ease-in-out"
          >
            <span className="font-semibold text-sm text-white">
              {isEditing ? "Edit" : "Add"}
            </span>
          </div>
        )}
      </div>
    </div>
  );
};

export default AddBannerDialogue;

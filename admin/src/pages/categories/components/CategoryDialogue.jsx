import React, { useState, useRef } from "react";
import useOutsideClick from "../../../useOutsideClick";
import FilePondPluginFileValidateType from "filepond-plugin-file-validate-type";
import FilePondPluginImageExifOrientation from "filepond-plugin-image-exif-orientation";
import FilePondPluginImagePreview from "filepond-plugin-image-preview";
import FilePondPluginFileEncode from "filepond-plugin-file-encode";
import "filepond-plugin-image-preview/dist/filepond-plugin-image-preview.css";
import { useSnackbar } from "notistack";
import Loader from "react-loader-spinner";

import { FilePond, registerPlugin } from "react-filepond";
import "filepond/dist/filepond.min.css";
import { addCategory } from "../../../api/categoriesApi";

// Register the plugins
registerPlugin(
  FilePondPluginImageExifOrientation,
  FilePondPluginImagePreview,
  FilePondPluginFileValidateType,
  FilePondPluginFileEncode
);

const CategoryDialogue = ({
  categoryAlert,
  setCategoryAlert,
  categoryInput,
  setCategoryInput,
}) => {
  const { enqueueSnackbar, closeSnackbar } = useSnackbar();
  const [file, setFile] = useState("");
  const [loading, setLoading] = useState(false);
  const ref = useRef();

  useOutsideClick(ref, () => {
    if (categoryAlert) {
      setCategoryAlert(false);
    }
  });

  const handleAdd = async (e) => {
    e.preventDefault();
    if (categoryInput) {
      try {
        setLoading(true);
        await addCategory(categoryInput, file[0].filename);
        setLoading(false);
        setCategoryAlert(false);
        enqueueSnackbar("Category added", {
          variant: "error",
          autoHideDuration: 2000,
        });
      } catch (error) {
        console.log(error);
        enqueueSnackbar(error.response.data.message, {
          variant: "error",
          autoHideDuration: 2000,
        });
      } finally {
        setLoading(false);
      }
    }
    setCategoryInput("");
  };

  return (
    <div
      ref={ref}
      className="flex flex-col py-10 w-1/3 rounded-3xl bg-blue-light justify-center px-16"
    >
      <div className="flex items-center justify-center">
        <input
          className="h-14 w-full rounded-2xl text-black bg-bgColor-light pl-4 mb-4 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent "
          placeholder="Name"
          type="text"
          value={categoryInput}
          onChange={(e) => {
            console.log(categoryInput);
            setCategoryInput(e.target.value);
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
        labelIdle='Drag & Drop category icon or <span class="filepond--label-action text-green-500 no-underline">Browse</span>'
      />

      <div className="flex items-center justify-center mt-6">
        <div
          onClick={(e) => {
            e.preventDefault();
            setCategoryAlert(false);
            setCategoryInput("");
          }}
          className="flex h-12 bg-red-500  shadow-sm border-none ml-4 w-32 rounded-xl  items-center justify-center cursor-pointer transform hover:scale-95  transition duration-500 ease-in-out"
        >
          <span className="font-semibold text-sm text-white">Cancel</span>
        </div>
        {loading ? (
          <div className="flex items-center justify-center ml-2">
            <Loader
              type="Puff"
              color="#00BFFF"
              height={50}
              width={50}
              timeout={3000} //3 secs
            />
          </div>
        ) : (
          <div
            onClick={handleAdd}
            className="flex h-12 bg-green-500  shadow-sm border-none ml-4 w-32 rounded-xl  items-center justify-center cursor-pointer transform hover:scale-95  transition duration-500 ease-in-out"
          >
            <span className="font-semibold text-sm text-white">Add</span>
          </div>
        )}
      </div>
    </div>
  );
};

export default CategoryDialogue;

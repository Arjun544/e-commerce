import React, { useState } from "react";
import TopBar from "../../components/TopBar";
import "filepond-plugin-image-preview/dist/filepond-plugin-image-preview.css";
import { FilePond } from "react-filepond";
import "filepond/dist/filepond.min.css";
import { sendNotificationToAllUsers } from "../../api/NotificationApi";
import { useSnackbar } from "notistack";
import Loader from "react-loader-spinner";

const Notification = () => {
  const [isLoading, setIsLoading] = useState(false);
  const [titleInput, setTitleInput] = useState("");
  const [bodyInput, setBodyInput] = useState("");
  const [file, setFile] = useState("");
  const { enqueueSnackbar } = useSnackbar();

  const handleSendNotification = async () => {
    try {
      if (!titleInput || !bodyInput) {
        enqueueSnackbar("Fields can't be empty", {
          variant: "warning",
          autoHideDuration: 2000,
        });
      } else if (file.length === 0) {
        setIsLoading(true);
        await sendNotificationToAllUsers(titleInput, bodyInput, null);
        enqueueSnackbar("Notification sent", {
          variant: "success",
          autoHideDuration: 2000,
        });
        setIsLoading(false);
      } else {
        setIsLoading(true);
        await sendNotificationToAllUsers(
          titleInput,
          bodyInput,
          // "https://cdn.vox-cdn.com/thumbor/Pkmq1nm3skO0-j693JTMd7RL0Zk=/0x0:2012x1341/1200x800/filters:focal(0x0:2012x1341)/cdn.vox-cdn.com/uploads/chorus_image/image/47070706/google2.0.0.jpg"
          file[0].getFileEncodeDataURL()
        );
        enqueueSnackbar("Notification sent", {
          variant: "success",
          autoHideDuration: 2000,
        });
        setIsLoading(false);
      }
    } catch (error) {
      setIsLoading(false);
      console.log(error);
      enqueueSnackbar("Something went wrong", {
        variant: "error",
        autoHideDuration: 2000,
      });
    }
  };

  return (
    <div className="flex-col w-full h-full overflow-hidden bg-white">
      <TopBar />
      <div className="flex-col h-full w-full items-center px-8 mt-2">
        <span className="text-black font-semibold text-xl">
          Send Notification
        </span>
        <div className="flex-col w-full items-center rounded-2xl bg-bgColor-light mt-4 px-4 py-8">
          <input
            className="h-14 w-full rounded-xl font-semibold text-black bg-white px-4 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent "
            placeholder={"Title"}
            value={titleInput}
            onChange={(e) => {
              e.preventDefault();
              setTitleInput(e.target.value);
            }}
          />
          <input
            className="h-14 mt-6 mb-32 w-full rounded-xl font-semibold text-black bg-white px-4 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent "
            placeholder={"Body"}
            value={bodyInput}
            onChange={(e) => {
              e.preventDefault();
              setBodyInput(e.target.value);
            }}
          />

          <FilePond
            files={file}
            allowReorder={false}
            allowMultiple={false}
            onupdatefiles={setFile}
            allowFileTypeValidation={true}
            allowFileEncode={true}
            acceptedFileTypes={["image/png", "image/jpeg"]}
            labelIdle="Drag & Drop notification image or <span class=filepond--label-action text-green-500 no-underline>Browse</span>"
          />

          <div className="flex items-center justify-center">
            {isLoading ? (
              <Loader
                type="Puff"
                color="#00BFFF"
                height={50}
                width={50}
              />
            ) : (
              <div
                onClick={handleSendNotification}
                className="flex h-12 mt-20 bg-green-500  shadow-sm border-none w-32 rounded-xl  items-center justify-center cursor-pointer transform hover:scale-95  transition duration-500 ease-in-out"
              >
                <span className="font-semibold text-sm text-white tracking-wider">
                  Send
                </span>
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};

export default Notification;

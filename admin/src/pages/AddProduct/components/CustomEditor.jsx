import React from "react";
import ReactQuill from "react-quill";
import 'react-quill/dist/quill.snow.css';
import "./editor.css";

const CustomEditor = ({ input, setInput }) => {
  return (
    <ReactQuill
      className="editor"
      placeholder="Full description"
      modules={CustomEditor.modules}
      formats={CustomEditor.formats}
      value={input}
      theme={"snow"}
      // bounds={".editior"}
      onChange={(e) => {
        setInput(e);
      }}
    ></ReactQuill>
  );
};

export default CustomEditor;

CustomEditor.modules = {
  toolbar: [
    [{ header: "1" }, { header: "2" }, { header: [3, 4, 5, 6] }, { font: [] }],
    [{ size: [] }],
    ["bold", "italic", "underline", "blockquote"],
    [{ list: "ordered" }, { list: "bullet" }],
    ["clean"],
    ["code-block"],
  ],
};

CustomEditor.formats = [
  "header",
  "font",
  "size",
  "bold",
  "italic",
  "underline",
  "blockquote",
  "list",
  "bullet",
  "code-block",
];

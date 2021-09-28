import React from "react";

const DeleteIcon = ({ className, onClick }) => {
  return (
    <svg
      onClick={onClick}
      className={className}
      id="Iconly_Bold_Delete"
      data-name="Iconly/Bold/Delete"
      xmlns="http://www.w3.org/2000/svg"
      width="24"
      height="24"
      viewBox="0 0 24 24"
    >
      <g id="Delete" transform="translate(3 2)">
        <path
          id="Delete-2"
          data-name="Delete"
          d="M5.132,19.961A2.916,2.916,0,0,1,2.2,17.134c-.313-2.847-.836-9.577-.846-9.645a.791.791,0,0,1,.191-.558A.708.708,0,0,1,2.068,6.7H15.939a.724.724,0,0,1,.523.234.745.745,0,0,1,.181.558c0,.068-.533,6.809-.837,9.645a2.918,2.918,0,0,1-3,2.827C11.515,19.99,10.249,20,9,20,7.681,20,6.387,19.99,5.132,19.961ZM.714,5.091A.73.73,0,0,1,0,4.357v-.38a.724.724,0,0,1,.714-.734H3.63A1.282,1.282,0,0,0,4.871,2.228l.152-.682A1.989,1.989,0,0,1,6.935,0h4.129a1.987,1.987,0,0,1,1.9,1.5l.163.73a1.28,1.28,0,0,0,1.241,1.016h2.916A.723.723,0,0,1,18,3.977v.38a.73.73,0,0,1-.713.734Z"
        />
      </g>
    </svg>
  );
};

export default DeleteIcon;

import React from 'react'

const Logo = ({ color }) => {
  return (
    <svg
      id="Activity"
      xmlns="http://www.w3.org/2000/svg"
      width="40"
      height="40"
      viewBox="0 0 24 24"
    >
      <rect
        id="Rectangle_7"
        data-name="Rectangle 7"
        width="40"
        height="40"
        fill="none"
      />
      <path
        id="Activity-2"
        data-name="Activity"
        d="M143.36,144.84h10a5,5,0,0,1,5,5v10a5,5,0,0,1-5,5h-10a5,5,0,0,1-5-5v-10A5,5,0,0,1,143.36,144.84Zm-1.69,6.87a6.73,6.73,0,0,0,3.87,3.81,5.66,5.66,0,0,0,2.92,0,4.59,4.59,0,0,1,2.21,0,5.46,5.46,0,0,1,3,3.11.75.75,0,0,0,.68.42.8.8,0,0,0,.37-.05.75.75,0,0,0,.34-1,6.687,6.687,0,0,0-4-3.88,5.77,5.77,0,0,0-2.92,0,4.35,4.35,0,0,1-2.21,0,5.4,5.4,0,0,1-3-3,.75.75,0,0,0-1-.34.74.74,0,0,0-.26.93Z"
        transform="translate(166.84 -136.36) rotate(90)"
        fill={color}
      />
    </svg>
  );
};

export default Logo

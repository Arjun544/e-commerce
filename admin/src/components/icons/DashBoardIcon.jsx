import React from 'react'

const DashBoardIcon = ({color}) => {
    return (
      <svg
        id="Statistics"
        xmlns="http://www.w3.org/2000/svg"
        width="28"
        height="28"
        viewBox="0 0 24 24"
      >
        <rect
          id="Rectangle_47"
          data-name="Rectangle 47"
          width="24"
          height="24"
          fill="none"
        />
        <path
          id="Statistics-2"
          data-name="Statistics"
          d="M153.36,144.84h-10a5,5,0,0,0-5,5v10a5,5,0,0,0,5,5h10a5,5,0,0,0,5-5v-10A5,5,0,0,0,153.36,144.84ZM144.5,160a.75.75,0,0,1-1.5,0v-4.88a.75.75,0,0,1,1.5,0Zm4.61,0a.75.75,0,0,1-1.5,0v-6.79a.75.75,0,0,1,1.5,0Zm4.62,0a.75.75,0,0,1-1.5,0V149.67a.75.75,0,0,1,1.5,0Z"
          transform="translate(-136.36 -142.84)"
          fill={color}
        />
      </svg>
    );
}

export default DashBoardIcon

import React from 'react'

const Avatar = ({value}) => {
    return (
      <div className="h-9 w-9 rounded-full overflow-hidden">
        <img src={value} alt="" />
      </div>
    );
}

export default Avatar;

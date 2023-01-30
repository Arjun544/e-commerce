import React from "react";

const RatingStars = ({ value }) => {
  return (
    <div className="h-100 w-10">
      <reactStars
        classNames="mr-2"
        value={2}
        count={5}
        edit={false}
        size={25}
        isHalf={true}
        emptyIcon={<i className="far fa-star"></i>}
        halfIcon={<i className="fa fa-star-half-alt"></i>}
        fullIcon={<i className="fa fa-star"></i>}
        color="#575757a9"
        activeColor="#ffd700"
      />
    </div>
  );
};

export default RatingStars;

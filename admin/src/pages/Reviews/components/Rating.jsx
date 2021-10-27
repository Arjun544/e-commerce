import React from 'react';
import ReactStars from "react-rating-stars-component";

const Rating = ({rating}) => {
    return (
      <ReactStars
        classNames="mr-2"
        value={rating}
        count={5}
        edit={false}
        size={30}
        isHalf={true}
        emptyIcon={<i className="far fa-star"></i>}
        halfIcon={<i className="fa fa-star-half-alt"></i>}
        fullIcon={<i className="fa fa-star"></i>}
        color="#575757a9"
        activeColor="#ffd700"
      />
    );
}

export default Rating;

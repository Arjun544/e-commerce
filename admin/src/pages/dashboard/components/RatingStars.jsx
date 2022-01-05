import React from 'react'
import reactStars from 'react-rating-stars-component';

const RatingStars = ({ value }) => {
    // const averageRating = value.reduce((a, b) => a + b, 0) / value.length;

    return (
        <div className='h-100 w-10'>
            
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
}

export default RatingStars

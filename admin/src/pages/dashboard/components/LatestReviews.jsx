import React, { useState, useEffect, useRef } from "react";
import Slider from "react-slick";
import { getRecentReviews } from "../../../api/reviewsApi";
import ReactStars from "react-rating-stars-component";
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";

const LatestReviews = () => {
  const [recentReviews, setRecentReviews] = useState([]);
  const reviewSlider = useRef(null);

  useEffect(() => {
    const getReviews = async () => {
      try {
        const { data } = await getRecentReviews();
        setRecentReviews(data.filteredReviews);
      } catch (error) {
      }
    };
    getReviews();
  }, []);

  const settings = {
    arrows: false,
    dots: false,
    autoplay: true,
    speed: 500,
    slidesToShow: 1,
    slidesToScroll: 1,
  };

  return (
    <div className="flex flex-col">
      <span className="text-black font-semibold">Recent Reviews</span>
      {recentReviews === undefined ? (
        <div className="flex h-full w-full pt-10 justify-center">
          <span className="text-black font-semibold">Loading</span>
        </div>
      ) : recentReviews.length === 0 ? (
        <div className="flex h-full w-full pt-10 justify-center">
          <span className="text-black font-semibold">No Reviews</span>
        </div>
      ) : (
        <Slider className="w-96 mt-5" ref={reviewSlider} {...settings}>
          {recentReviews.map((review) => {
            return (
              <div className="flex">
                <div className="flex">
                  {review.user.profile ? (
                    <img
                      className="h-12 w-12 rounded-full object-cover mt-1"
                      src={review.user.profile}
                      alt=""
                    />
                  ) : (
                    <img
                      className="h-12 w-12 rounded-full object-cover"
                      src="https://schooloflanguages.sa.edu.au/wp-content/uploads/2017/11/placeholder-profile-sq.jpg"
                      alt=""
                    />
                  )}
                  <div className="flex flex-col ml-4">
                    <span className="text-black font-semibold text-base capitalize">
                      {review.user.username}
                    </span>
                    <ReactStars
                      classNames="mb-2"
                      value={review.rating}
                      count={5}
                      edit={false}
                      size={20}
                      isHalf={true}
                      emptyIcon={<i className="far fa-star"></i>}
                      halfIcon={<i className="fa fa-star-half-alt"></i>}
                      fullIcon={<i className="fa fa-star"></i>}
                      color="#575757a9"
                      activeColor="#ffd700"
                    />
                  </div>
                </div>

                <span className="text-black font-semibold text-sm pt-1 capitalize">
                  {review.review}
                </span>
              </div>
            );
          })}
        </Slider>
      )}
    </div>
  );
};

export default LatestReviews;

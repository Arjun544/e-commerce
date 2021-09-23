import React, { useState, useEffect } from "react";
import { Carousel } from "react-responsive-carousel";
import { getRecentReviews } from "../../../api/productsApi";

const LatestReviews = () => {
  const [recentReviews, setRecentReviews] = useState([]);

  useEffect(() => {
    const getReviews = async () => {
      try {
        const { data } = await getRecentReviews();
        setRecentReviews(data);
        console.log(data);
      } catch (error) {
        console.log(error.response);
      }
    };
    getReviews();
  }, []);
  return (
    <div className="flex flex-col justify-between">
      <div className="flex justify-between">
        <span className="text-black font-semibold">Recent Reviews</span>
        <span className="text-red-500 font-semibold">View All</span>
      </div>
      {recentReviews.map((review) => {
        return (
          <Carousel showArrows={false} autoPlay={true}>
            <span className="text-black font-semibold">{review.review}</span>
          </Carousel>
        );
      })}
    </div>
  );
};

export default LatestReviews;

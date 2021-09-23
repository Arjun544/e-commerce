import React from "react";
import { Carousel } from "react-responsive-carousel";

const LatestReviews = () => {
  return (
    <div className="flex flex-col justify-between">
      <div className="flex justify-between">
        <span className="text-black font-semibold">Recent Reviews</span>
        <span className="text-red-500 font-semibold">View All</span>
      </div>
      <Carousel
        showArrows={false}
        autoPlay={true}
      >
        <span className="text-black font-semibold">Recent Reviews 1</span>
        <span className="text-black font-semibold">Recent Reviews 2</span>
        <span className="text-black font-semibold">Recent Reviews 3</span>
        <span className="text-black font-semibold">Recent Reviews 4</span>
        <span className="text-black font-semibold">Recent Reviews 5</span>
      </Carousel>
    </div>
  );
};

export default LatestReviews;

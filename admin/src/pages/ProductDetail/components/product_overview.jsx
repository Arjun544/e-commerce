import React, { useState } from "react";
import ReactStars from "react-rating-stars-component";

const ProductOverview = ({ product, averageRating }) => {
  const [selectedImage, setSelectedImage] = useState(0);

  const onImageClick = (e, index) => {
    e.preventDefault();
    setSelectedImage(index);
  };
  return (
    <div className="flex h-2/4  bg-bgColor-light rounded-2xl p-8 mb-6">
      <div className="flex flex-col h-3/4 w-1/3 rounded-2xl ">
        <img
          className="w-full h-full object-cover rounded-2xl"
          src={product.images[selectedImage].url}
          alt=""
        />

        <div className="flex h-16 w-full object-cover bg-transparent justify-between mt-8">
          {product.images.map((image, index) => (
            <img
              onClick={(e) => onImageClick(e, index)}
              className={`h-16 w-16 rounded-xl object-cover ${
                index === selectedImage && "border-customYellow-light border-4"
              }`}
              src={image.url}
              alt=""
            />
          ))}
        </div>
      </div>
      <div className="flex flex-col ml-10 h-3/4 justify-between ">
        <div className="flex flex-col">
          <span className="text-gray-500 font-semibold text-xs capitalize mb-2">
            {product.category.name}
          </span>
          <span className="text-black font-semibold text-xl">
            {product.name}
          </span>
          <div className="flex my-3 items-center">
            <span className="text-gray-500 font-semibold text-xs mr-2 ">
              Stock
            </span>
            <span className="text-black font-semibold text-sm">
              {product.countInStock}
            </span>
          </div>
          {product.onSale ? (
            <div className="flex">
              <span className="text-gray-300 line-through font-semibold text-base mr-2">
                ${product.price}
              </span>
              <span className="text-gray-500 font-semibold text-base">
                ${product.totalPrice}
              </span>
            </div>
          ) : (
            <span className="text-gray-500 font-semibold text-base">
              ${product.price}
            </span>
          )}
        </div>

        <span className="text-gray-500 font-semibold text-base">
          {product.description}
        </span>

        <ReactStars
          classNames="mr-2"
          value={averageRating}
          count={5}
          edit={false}
          size={24}
          isHalf={true}
          emptyIcon={<i className="far fa-star"></i>}
          halfIcon={<i className="fa fa-star-half-alt"></i>}
          fullIcon={<i className="fa fa-star"></i>}
          color="#575757a9"
          activeColor="#ffd700"
        />
      </div>
    </div>
  );
};

export default ProductOverview;

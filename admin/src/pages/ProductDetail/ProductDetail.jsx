import React, { useState, useEffect } from "react";
import { useParams } from "react-router-dom";
import TopBar from "../../components/TopBar";
import { getProductById } from "../../api/productsApi";
import Loader from "react-loader-spinner";
import ProductOverview from "./components/product_overview";
import ReactStars from "react-rating-stars-component";

const ProductDetail = () => {
  const params = useParams();
  const [selectedTab, setSelectedTab] = useState(0);
  const [product, setProduct] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const productId = params.id;
  let averageRating;

  useEffect(() => {
    const getProduct = async () => {
      try {
        setIsLoading(true);
        const { data } = await getProductById(productId);
        setProduct(data.products);
        console.log(data.products);
        setIsLoading(false);
      } catch (error) {
        setIsLoading(false);
        console.log(error.response);
      }
    };
    getProduct();
  }, []);

  console.log(product);
  //calculating avg rating from all ratings
  if (product.totalReviews > 0) {
    const ratings = product.reviews.map((review) => parseFloat(review.number));
    averageRating = ratings.reduce((a, b) => a + b, 0) / ratings.length;
  }
  return (
    <div className="flex flex-col w-full h-full mt-30 overflow-y-auto overflow-x-hidden  bg-white">
      <TopBar />

      {isLoading || product.length === 0 ? (
        <div className="flex w-full h-screen items-center justify-center bg-white">
          <Loader
            type="Puff"
            color="#00BFFF"
            height={50}
            width={50}
            timeout={3000} //3 secs
          />
        </div>
      ) : (
        <div className="flex h-full flex-col px-8 mb-10 bg-white">
          {/* Product Overview */}
          <ProductOverview product={product} averageRating={averageRating} />

          {/* Product desc */}
          <div className="flex flex-grow bg-bgColor-light p-4 rounded-2xl">
            <div className="flex flex-col w-full px-5">
              {/* Tabs */}
              <div className="tabs tabs-boxed flex w-1/5 items-center justify-between h-16 rounded-3xl cursor-pointer">
                <a
                  onClick={(e) => {
                    e.preventDefault();
                    setSelectedTab(0);
                  }}
                  className={
                    selectedTab === 0
                      ? "tabs tab-active w-32 h-10 items-center bg-customYellow-light justify-center font-semibold  text-white tracking-wide bg-amber-light rounded-2xl transform hover:scale-110 transition duration-500 ease-in-out"
                      : "tabs w-28 h-10 items-center justify-center font-semibold text-gray-400 tracking-wide"
                  }
                >
                  Description
                </a>
                <a
                  onClick={(e) => {
                    e.preventDefault();
                    setSelectedTab(1);
                  }}
                  className={
                    selectedTab === 1
                      ? "tabs tab-active w-32 h-10 items-center bg-customYellow-light justify-center font-semibold  text-white tracking-wide bg-amber-light rounded-2xl transform hover:scale-110 transition duration-500 ease-in-out"
                      : "tabs w-28 h-10 items-center justify-center font-semibold text-gray-400 tracking-wide"
                  }
                >
                  Reviews ({product.reviews.length})
                </a>
              </div>
              {/* Tab Views */}
              {selectedTab === 0 ? (
                <div>
                  <span className="text-black">{product.fullDescription}</span>
                </div>
              ) : (
                <div className="flex flex-col h-full w-full ">
                  <span className="text-black font-semibold text-2xl mb-4">
                    {averageRating}
                  </span>
                  <div className="flex items-center ">
                    <ReactStars
                      classNames="mr-2"
                      value={averageRating}
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
                    <span className="text-black font-semibold text-lg pt-1">
                      ({product.totalReviews})
                    </span>
                  </div>

                  {product.reviews.map((review) => {
                    return (
                      <div className="flex mb-4 bg-white p-4 items-start justify-start rounded-2xl mt-3">
                        <img
                          className="h-12 w-12 rounded-full object-cover mt-1"
                          src={review.user.profile}
                          alt=""
                        />
                        <div className="flex flex-col ml-3">
                          <span className="text-black font-semibold text-base capitalize">
                            {review.user.username}
                          </span>
                          <ReactStars
                            classNames="mb-2"
                            value={review.number}
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
                          <span className="text-black font-semibold text-sm pt-1 capitalize">
                            {review.review}
                          </span>
                        </div>
                      </div>
                    );
                  })}
                </div>
              )}
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default ProductDetail;

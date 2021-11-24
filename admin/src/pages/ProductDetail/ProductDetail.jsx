import React, { useState, useEffect } from "react";
import { useParams, useHistory } from "react-router-dom";
import TopBar from "../../components/TopBar";
import { getProductById } from "../../api/productsApi";
import Lottie from "lottie-react";
import empty from "../../assets/images/empty";
import Loader from "react-loader-spinner";
import ProductOverview from "./components/product_overview";
import ReactStars from "react-rating-stars-component";
import { Breadcrumb, Breadcrumbs } from "react-rainbow-components";

const ProductDetail = () => {
  const params = useParams();
  const history = useHistory();
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

  //calculating avg rating from all ratings
  if (product.totalReviews > 0) {
    const ratings = product.reviews.map((review) => parseFloat(review.rating));
    averageRating = ratings.reduce((a, b) => a + b, 0) / ratings.length;
  }
  return (
    <div className="flex flex-col w-full h-full mt-30 overflow-y-auto overflow-x-hidden bg-white">
      <TopBar />
      <div className="flex ml-10 my-6">
        <Breadcrumbs>
          <Breadcrumb label="Products" onClick={() => history.push('/products')} />
          <Breadcrumb label="Product Detail" />
        </Breadcrumbs>
      </div>
      {isLoading ? (
        <div className="flex w-full h-screen items-center justify-center bg-white">
          <Loader
            type="Puff"
            color="#00BFFF"
            height={50}
            width={50}
            timeout={3000} //3 secs
          />
        </div>
      ) : product.length === 0 ? (
        <div className="flex flex-col items-center justify-center m-auto">
          <Lottie className="h-40" animationData={empty} />
          <span className="font-bold text-gray-300">No product found</span>
        </div>
      ) : (
        <div className="flex h-full flex-col px-8 mb-10 bg-white">
          {/* Product Overview */}
          <ProductOverview product={product} averageRating={averageRating} />

          {/* Product desc */}
          <div className="flex bg-bgColor-light p-4 rounded-2xl">
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
                      ? "tabs tab-active w-32 h-10 items-center bg-customYellow-light justify-center font-semibold  text-white tracking-wide bg-amber-light rounded-2xl transform hover:scale-95 transition duration-500 ease-in-out"
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
                      ? "tabs tab-active w-32 h-10 items-center bg-customYellow-light justify-center font-semibold  text-white tracking-wide bg-amber-light rounded-2xl transform hover:scale-95 transition duration-500 ease-in-out"
                      : "tabs w-28 h-10 items-center justify-center font-semibold text-gray-400 tracking-wide"
                  }
                >
                  Reviews ({product.reviews.length})
                </a>
              </div>
              {/* Tab Views */}
              {selectedTab === 0 ? (
                <span className="font-semibold text-black">
                  {product.fullDescription}
                </span>
              ) : product.reviews.length === 0 ? (
                <span className="font-semibold">No reviews</span>
              ) : (
                <div className="flex flex-col h-full w-full ">
                  {product.reviews.map((review) => {
                    return (
                      <div className="flex mb-4 bg-white p-4 items-start justify-start rounded-2xl mt-3">
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
                        <div className="flex flex-col ml-3">
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

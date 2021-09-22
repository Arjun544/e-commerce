import React, { useState, useEffect } from "react";
import { useParams } from "react-router-dom";
import TopBar from "../../components/TopBar";
import { getProductById } from "../../api/productsApi";

const ProductDetail = () => {
  const params = useParams();
  const [selectedImage, setSelectedImage] = useState(0);
  const [product, setProduct] = useState({});
  const productId = params.id;

  const onImageClick = (e, index) => {
    e.preventDefault();
    setSelectedImage(index);
  };

  useEffect(() => {
    const getProduct = async () => {
     try {
        const response = await getProductById(productId);
        console.log(response);
     } catch (error) {
       console.log(error.response);
     }
    };
    getProduct();
  }, [product]);

  return (
    <div className="flex flex-col w-full h-full mt-30 overflow-y-auto overflow-x-hidden  bg-white">
      <TopBar />

      {/* <div className="flex flex-col px-8">
        <span className="text-black font-semibold text-xl">{product.name}</span>

        <div className="flex flex-col mt-4">
          <div className="flex h-44 w-1/5 shadow-md rounded-2xl">
            <img
              className="w-full h-full object-cover rounded-2xl"
              src={product.images[selectedImage].url}
              alt=""
            />
          </div>
          <div className="flex h-16 w-1/5 object-cover bg-white justify-between mt-4">
            {product.images.map((image, index) => (
              <img
                onClick={(e) => onImageClick(e, index)}
                className={`h-16 w-16 rounded-xl object-cover ${
                  index === selectedImage &&
                  "border-customYellow-light border-4"
                }`}
                src={image.url}
                alt=""
              />
            ))}
          </div>
        </div>
      </div> */}
    </div>
  );
};

export default ProductDetail;

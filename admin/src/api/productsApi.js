import axios from "axios";

const api = axios.create();
const BaseUrl = process.env.REACT_APP_API_URL;

// List of all the endpoints
export const addProduct = async (
  name,
  description,
  fullDescription,
  category,
  countInStock,
  isFeatured,
  price,
  image,
  subCategory,
  onSale,
  discount
) => {
  const res = await api.post(
    `${BaseUrl}/api/products/add`,
    {
      name,
      description,
      fullDescription,
      category,
      countInStock,
      isFeatured,
      price,
      image,
      subCategory,
      onSale,
      discount,
    },
    {
      headers: {
        "Content-type": "application/json",
        Accept: "application/json",
      },
    }
  );
  const json = await res.json();
  return json;
};

export const uploadMultiImages = async (id, images) => {
  const res = await api.patch(
    `${BaseUrl}/api/products/multipleImages/${id}`,
    { images },
    {
      headers: {
        Authorization: `Bearer ${JSON.parse(
          localStorage.getItem("accessToken")
        )}`,
        "Content-type": "application/json",
        Accept: "application/json",
      },
    }
  );
  const json = await res.json();
  return json;
};

export const getProducts = async (page, limit, pagination) => {
  const res = await api.get(
    `${BaseUrl}/api/products/getAdminProducts?page=${page}&limit=${limit}&pagination=${pagination}`,
    {
      headers: {
        Authorization: `Bearer ${JSON.parse(
          localStorage.getItem("accessToken")
        )}`,
        "Content-type": "application/json",
      },
    }
  );
  const json = await res.json();
  return json;
};

export const getProductById = async (id) => {
  const res = await api.get(`${BaseUrl}/api/products/${id}`, {
    headers: {
      Authorization: `Bearer ${JSON.parse(
        localStorage.getItem("accessToken")
      )}`,
      "Content-type": "application/json",
    },
  });
  const json = await res.json();
  return json;
};

export const updateProduct = async (
  id,
  name,
  description,
  fullDescription,
  category,
  countInStock,
  isFeatured,
  price,
  image,
  subCategory,
  onSale,
  discount,
  thumbnailId,
  imageIds
) => {
  const res = await api.patch(
    `${BaseUrl}/api/products/update/${id}`,
    {
      name,
      description,
      fullDescription,
      category,
      countInStock,
      isFeatured,
      price,
      image,
      subCategory,
      onSale,
      discount,
      thumbnailId,
      imageIds,
    },
    {
      headers: {
        Authorization: `Bearer ${JSON.parse(
          localStorage.getItem("accessToken")
        )}`,
        "Content-type": "application/json",
        Accept: "application/json",
      },
    }
  );
  const json = await res.json();
  return json;
};

export const updateFeatured = async (id, isFeatured) => {
  const res = await api.patch(
    `${BaseUrl}/api/products/updateFeatured/${id}/${isFeatured}`,
    {},
    {
      headers: {
        Authorization: `Bearer ${JSON.parse(
          localStorage.getItem("accessToken")
        )}`,
        "Content-type": "application/json",
        Accept: "application/json",
      },
    }
  );
  const json = await res.json();
  return json;
};
export const updateStatus = async (id, status) => {
  const res = await api.patch(
    `${BaseUrl}/api/products/updateStatus/${id}/${status}`,
    {},
    {
      headers: {
        Authorization: `Bearer ${JSON.parse(
          localStorage.getItem("accessToken")
        )}`,
        "Content-type": "application/json",
        Accept: "application/json",
      },
    }
  );
  const json = await res.json();
  return json;
};

export const deleteProduct = async (id, thumbnailId, imageIds) => {

  const res = await api.delete(`${BaseUrl}/api/products/delete/${id}`, {
    headers: {
      Authorization: `Bearer ${JSON.parse(
        localStorage.getItem("accessToken")
      )}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
    data: { thumbnailId: thumbnailId, imageIds: imageIds },
  });
  const json = await res.json();
  return json;
}

export default api;

import axios from "axios";

const api = axios.create();
const BaseUrl = process.env.REACT_APP_API_URL;

// List of all the endpoints
export const getCategories = async () => {
  const res = await api.get(`${BaseUrl}/api/categories/getAdminCategories`, {
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

export const addCategory = async (name, icon) => {
  const res = await api.post(
    `${BaseUrl}/api/categories/add`,
    { name, icon },
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
    `${BaseUrl}/api/categories/updateStatus/${id}/${status}`,
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

export const addSubCategory = async (id, name) => {
  const res = await api.patch(
    `${BaseUrl}/api/categories/addSubCategory/${id}`,
    { name },
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

export const updateCategory = async (id, name, icon, iconId) => {
  const res = await api.patch(
    `${BaseUrl}/api/categories/update/${id}`,
    { name, icon, iconId },
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

export const updateSubCategory = async (id, subCategoryId, name) => {
  const res = await api.patch(
    `${BaseUrl}/api/categories/updateSubCategory/${id}`,
    { subCategoryId, name },
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

export const deleteCategory = async (id, iconId) => {
  const res = await api.delete(`${BaseUrl}/api/categories/${id}`, {
    headers: {
      Authorization: `Bearer ${JSON.parse(
        localStorage.getItem("accessToken")
      )}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
    data: { iconId: iconId },
  });
  const json = await res.json();
  return json;
};
export const deleteSubCategory = async (id, subCategoryId) => {
  const res = await api.delete(`${BaseUrl}/api/categories/subCategory/${id}`, {
    headers: {
      Authorization: `Bearer ${JSON.parse(
        localStorage.getItem("accessToken")
      )}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
    data: { subCategoryId: subCategoryId },
  });
  const json = await res.json();
  return json;
};

export default api;

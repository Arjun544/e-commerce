import React, { useContext, useEffect, useState } from "react";
import { AppContext } from "../../App";
import Featured from "./components/featured";
import Status from "./components/status";
import ProductsTable from "./components/products_table";
import TableActions from "./components/table_actions";
import TopBar from "../../components/TopBar";
import { useDispatch } from "react-redux";
import { useSelector } from "react-redux";
import { setProducts } from "../../redux/productsSlice";
import { getProducts } from "../../api/productsApi";
import Loader from "react-loader-spinner";
import Avatar from "./components/avatar";

const Products = () => {
  const dispatch = useDispatch();
  const [isLoading, setIsLoading] = useState(false);
  const [tableData, setTableData] = useState([]);
  const { products } = useSelector((state) => state.products);
  const { isBigScreen } = useContext(AppContext);
  useEffect(() => {
    const fetchProducts = async () => {
      try {
        setIsLoading(true);
        const { data } = await getProducts();
        dispatch(setProducts(data.products));
        setTableData(data.products);
        setIsLoading(false);
      } catch (error) {
        setIsLoading(false);
        console.log(error.response);
      }
    };
    fetchProducts();
  }, []);

  const data = tableData.map((item) => ({
    product: item,
    image: item.thumbnail,
    name: item.name,
    date: item.dateCreated,
    price: item.price,
    featured: item.isFeatured,
    status: item.status,
  }));

  const columns = [
    {
      Header: "No",
      maxWidth: 10,
      accessor: "",
      Cell: (row) => {
        return <div>{row.row.index + 1}</div>;
      },
      disableSortBy: true,
      disableFilters: true,
    },
    {
      Header: "Image",
      accessor: "image",
      Cell: (props) => <Avatar value={props.cell.value} />,
    },
    {
      Header: "Name",
      accessor: "name",
    },
    {
      Header: "Date",
      accessor: "date",
    },
    {
      Header: "Price",
      accessor: "price",
    },
    {
      Header: "Featured",
      accessor: "featured",
      Cell: (props) => <Featured product={props.cell.row.original.product} />,
    },
    {
      Header: "Status",
      accessor: "status",
      Cell: (props) => <Status product={props.cell.row.original.product} />,
    },

    {
      Header: "Actions",
      Cell: (props) => (
        <TableActions
          product={props.cell.row.original.product}
          setIsLoading={setIsLoading}
          setTableData={setTableData}
        />
      ),
    },
  ];

  return (
    <div className="flex flex-col w-full h-full overflow-y-auto overflow-x-hidden  bg-white">
      <TopBar />
      {/* Views */}
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
      ) : (
        <div className="px-10">
          <ProductsTable columns={columns} data={data} />
        </div>
      )}
    </div>
  );
};

export default Products;

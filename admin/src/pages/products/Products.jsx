import React, { useEffect, useState } from "react";
import Featured from "./components/featured";
import Status from "./components/status";
import ProductsTable from "./components/products_table";
import TableActions from "./components/table_actions";
import TopBar from "../../components/TopBar";
import { getProducts } from "../../api/productsApi";
import Loader from "react-loader-spinner";
import Avatar from "./components/avatar";
import { useHistory } from "react-router-dom";
import moment from "moment";

const Products = () => {
  const history = useHistory();
  const [isLoading, setIsLoading] = useState(false);
  const [currentPage, setCurrentPage] = useState(1);
  const [tableData, setTableData] = useState({});

  useEffect(() => {
    const fetchProducts = async () => {
      try {
        setIsLoading(true);
        const { data } = await getProducts(currentPage, 10, true);
        setTableData(data);
        setIsLoading(false);
      } catch (error) {
        setIsLoading(false);
        console.log(error.response);
      }
    };
    fetchProducts();
  }, [currentPage]);

  const data =
    !isLoading &&
    tableData.results !== undefined &&
    tableData?.results.map((item) => ({
      product: item,
      image: item.thumbnail,
      name: item.name,
      date: item.dateCreated,
      price: item.price,
      category: item.category.name,
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
      Cell: (props) => (
        <span
          onClick={(e) =>
            history.push(`/products/view/${props.cell.row.original.product.id}`)
          }
          className="text-green-500 text-sm font-semibold cursor-pointer"
        >
          {props.cell.value}
        </span>
      ),
    },
    {
      Header: "Date",
      accessor: "date",
      Cell: (props) => (
        <span className="text-gray-500">
          {moment(props.cell.value).format("ll")}
        </span>
      ),
    },
    {
      Header: "Price",
      accessor: "price",
    },
    {
      Header: "Category",
      accessor: "category",
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
          tableData={tableData}
          setTableData={setTableData}
        />
      ),
    },
  ];

  return (
    <div className="flex flex-col w-full h-full overflow-y-auto overflow-x-hidden bg-white">
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
          {!isLoading && tableData.results !== undefined && (
            <ProductsTable
              columns={columns}
              data={data}
              setCurrentPage={setCurrentPage}
              currentPage={currentPage}
              totalPages={tableData.total_pages}
              hasNextPage={tableData.hasNextPage}
              hasPrevPage={tableData.hasPrevPage}
            />
          )}
        </div>
      )}
    </div>
  );
};

export default Products;

import React, { useContext, useEffect, useState } from "react";
import { AppContext } from "../../App";
import TopBar from "../../components/TopBar";
import Rating from "./components/Rating";
import TableAction from "./components/TableAction";
import { getAllReviews } from "../../api/reviewsApi";
import Loader from "react-loader-spinner";

const Reviews = () => {
  const [isLoading, setIsLoading] = useState(false);
  const [tableData, setTableData] = useState([]);
  const { isBigScreen } = useContext(AppContext);
  useEffect(() => {
    const fetchReviews = async () => {
      try {
        setIsLoading(true);
        const { data } = await getAllReviews();
        console.log(data.reviews);
        setTableData(data.reviews);
        setIsLoading(false);
      } catch (error) {
        setIsLoading(false);
        console.log(error.response);
      }
    };
    fetchReviews();
  }, []);

  const data = tableData.map((item) => ({
    review: item,
    product: item.product,
    customerName: item.user.username,
    date: item.addedAt.addedAt,
    review: item.review,
    rating: item.number,
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
      Header: "Product",
      accessor: "product",
    },
    {
      Header: "Customer",
      accessor: "customerName",
    },
    {
      Header: "Date",
      accessor: "date",
    },
    {
      Header: "Review",
      accessor: "review",
    },
    {
      Header: "Rating",
      accessor: "rating",
      Cell: (props) => <Rating rating={props.cell.value} />,
    },
    {
      Header: "Actions",
      Cell: (props) => (
        <TableAction
          review={props.cell.row.original.review}
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
          {/* <ProductsTable columns={columns} data={data} /> */}
        </div>
      )}
    </div>
  );
};

export default Reviews;

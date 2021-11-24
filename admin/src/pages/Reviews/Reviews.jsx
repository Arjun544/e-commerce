import React, { useContext, useEffect, useState } from "react";
import { AppContext } from "../../App";
import TopBar from "../../components/TopBar";
import Rating from "./components/Rating";
import TableAction from "./components/TableAction";
import { getAllReviews } from "../../api/reviewsApi";
import Loader from "react-loader-spinner";
import ReviewsTable from "./components/ReviewsTable";

const Reviews = () => {
  const [isLoading, setIsLoading] = useState(false);
  const [tableData, setTableData] = useState([]);
  const { isBigScreen } = useContext(AppContext);
  useEffect(() => {
    const fetchReviews = async () => {
      try {
        setIsLoading(true);
        const { data } = await getAllReviews();
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
    product: item.product.name,
    customerName: item.user.username,
    date: item.addedAt,
    reviewText: item.review,
    rating: item.rating,
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
      accessor: "reviewText",
    },
    {
      Header: "Rating",
      accessor: "rating",
      Cell: (props) => <Rating rating={props.cell.value} />,
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
          <ReviewsTable columns={columns} data={data} />
        </div>
      )}
    </div>
  );
};

export default Reviews;

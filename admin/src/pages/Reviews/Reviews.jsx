import React, { useEffect, useState } from "react";
import TopBar from "../../components/TopBar";
import Rating from "./components/Rating";
import { getAllReviews } from "../../api/reviewsApi";
import Loader from "react-loader-spinner";
import ReviewsTable from "./components/ReviewsTable";
import { useHistory } from "react-router-dom";

const Reviews = () => {
   const history = useHistory();
  const [isLoading, setIsLoading] = useState(false);
  const [currentPage, setCurrentPage] = useState(1);
  const [tableData, setTableData] = useState({});
  useEffect(() => {
    const fetchReviews = async () => {
      try {
        setIsLoading(true);
        const { data } = await getAllReviews(currentPage, 10, true);
        setTableData(data);
        setIsLoading(false);
      } catch (error) {
        setIsLoading(false);
        console.log(error.response);
      }
    };
    fetchReviews();
  }, [currentPage]);

  const data =
    !isLoading &&
    tableData.results !== undefined &&
    tableData?.results.map((item) => ({
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
      Cell: (props) => (
        <span
          onClick={(e) =>
            history.push(
              `/products/view/${props.cell.row.original.review.product._id}`
            )
          }
          className="text-green-500 text-sm font-semibold cursor-pointer"
        >
          {props.cell.value}
        </span>
      ),
    },
    {
      Header: "Customer",
      accessor: "customerName",
      Cell: (props) => (
        <span
          onClick={(e) =>
            history.push(
              `/customers/view/${props.cell.row.original.review.user._id}`
            )
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
          />
        </div>
      ) : (
        <div className="px-10">
          {!isLoading && tableData.results !== undefined && (
            <ReviewsTable
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

export default Reviews;

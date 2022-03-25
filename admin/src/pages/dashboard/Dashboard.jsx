import React, { useContext, useEffect, useState } from "react";
import { AppContext } from "../../App";

import CustomersPaymentChart from "./components/CustomersPaymentChart";
import EarningChart from "./components/EarningChart";
import OverviewChart from "./components/OverviewChart";
import OrdersMenu from "./components/Orders_Menu";
import TopProductsTable from "./components/TopProductsTable";
import TopBar from "../../components/TopBar";
import AllOrders from "./components/AllOrders";
import LatestReviews from "./components/LatestReviews";
import AllReviews from "./components/AllReviews";
import ProductsSold from "./components/ProductsSold";
import TopCustomers from "./components/TopCustomers";
import OrderStats from "./components/OrderStats";
import { getOrders } from "../../api/ordersApi";
import { useDispatch, useSelector } from "react-redux";
import { setOrders } from "../../redux/reducers/ordersSlice";
import OrderStatsLoader from "../../components/loaders/OrderStatsLoader";
import { getUsers } from "../../api/userApi";
import { setCustomers } from "../../redux/reducers/customersSlice";
import { setProducts } from "../../redux/reducers/productsSlice";
import { getProducts } from "../../api/productsApi";
import { setcategories } from "../../redux/reducers/categoriesSlice";
import { getCategories } from "../../api/categoriesApi";
import Avatar from "../products/components/avatar";
import { getAllReviews } from "../../api/reviewsApi";
import { useHistory } from "react-router-dom";

const Dashboard = () => {
  const history = useHistory();
  const { isBigScreen } = useContext(AppContext);
  const dispatch = useDispatch();
  const [reviews, setReviews] = useState([]);
  const { products } = useSelector((state) => state.products);
  const [isOrderMenuOpen, setIsOrderMenuOpen] = useState(false);
  const [isOrdersLoading, setIsOrdersLoading] = useState(false);
  const [isLoading, setIsLoading] = useState(false)

  useEffect(() => {
    const fetchOrders = async () => {
      try {
        setIsOrdersLoading(true);
        const { data } = await getOrders( false);
        dispatch(setOrders({ orders: data.results }));
        setIsOrdersLoading(false);
        console.log('ordersssss', data.results);
      } catch (error) {
        setIsOrdersLoading(false);
        console.log(error.response);
      }
    };
    const fetchCustomers = async () => {
      try {
        setIsLoading(true);
        const { data } = await getUsers(false);
        dispatch(setCustomers({ customers: data.results }));
        setIsLoading(false);
      } catch (error) {
        setIsLoading(false);
        console.log(error.response);
      }
    };
    const fetchProducts = async () => {
      try {
        setIsLoading(true);
        const { data } = await getProducts(false);
        dispatch(setProducts({ products: data.results }));
        setIsLoading(false);
      } catch (error) {
        setIsLoading(false);
        console.log(error.response);
      }
    };
    const fetchCategories = async () => {
      try {
        setIsLoading(true);
        const { data } = await getCategories();
        dispatch(setcategories(data.categoryList));
        setIsLoading(false);
      } catch (error) {
        setIsLoading(false);
        console.log(error.response);
      }
    };
    const fetchReviews = async () => {
      try {
        setIsLoading(true);
        const { data } = await getAllReviews(1, 1, false);
        setReviews(data.results);
        setIsLoading(false);
      } catch (error) {
        setIsLoading(false);
        console.log(error.response);
      }
    };
    fetchOrders();
    fetchCustomers();
    fetchProducts();
    fetchCategories();
    fetchReviews();
  }, []);

  const onTodaysOrdersClick = (e) => {
    e.preventDefault();
    setIsOrderMenuOpen(true);
  };

  const productsData = products
    .slice(0, 10)
    .sort(function (a, b) {
      if (a.totalReviews > b.totalReviews) return -1;
      if (a.totalReviews < b.totalReviews) return 1;
      return 0;
    })
    .map((item) => ({
      product: item,
      image: item.thumbnail,
      name: item.name,
      date: item.dateCreated,
      price: item.price,
      ratings: item.reviews.map((e) => parseFloat(e.rating)),
    }));

  const productsColumns = [
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
    },
    {
      Header: "Price",
      accessor: "price",
    },
    {
      Header: "Ratings",
      accessor: "ratings",
      Cell: (props) => (
        <span className="text-gray-500">
          {isNaN(parseFloat(props.cell.value))
            ? "none"
            : props.cell.value.reduce((a, b) => a + b, 0) /
              props.cell.value.length}
        </span>
      ),
    },
  ];

  return (
    <div className="flex flex-col w-full h-full overflow-y-auto bg-white scrollbar scrollbar-thin hover:scrollbar-thumb-gray-900 scrollbar-thumb-gray-500 scrollbar-track-gray-300">
      {isOrderMenuOpen && (
        <OrdersMenu
          isOrderMenuOpen={isOrderMenuOpen}
          setIsOrderMenuOpen={setIsOrderMenuOpen}
        />
      )}
      <TopBar />
      <div className="flex my-6 px-6">
        {/* DashBoard  */}
        <div className={`flex flex-col w-full mr-6`}>
          <div className="flex items-center justify-between">
            <div className="flex flex-col">
              <span className="text-black font-semibold text-xl tracking-wide">
                Dashboard
              </span>
              <span className="text-gray-300 font-semibold text-sm">
                Detailed information about yor store
              </span>
            </div>

            <div
              onClick={onTodaysOrdersClick}
              className="flex relative h-12 bg-darkBlue-light shadow-sm border-none ml-4 w-40 rounded-xl hover:bg-Grey-dark items-center justify-center cursor-pointer"
            >
              <span className="font-semibold text-sm text-white">
                Today's Orders
              </span>
            </div>
          </div>
          {/* Orders stats */}
          {isOrdersLoading ? <OrderStatsLoader /> : <OrderStats />}
          {/*  */}
          <div className={`flex mt-12 ${!isBigScreen && "flex-col"}`}>
            <div
              className={`h-full flex-grow ${
                isBigScreen ? "mr-6" : "mb-6"
              } bg-bgColor-light rounded-3xl p-6 shadow-sm`}
            >
              <EarningChart />
            </div>

            <div
              className={`flex h-full flex-grow-0  bg-bgColor-light rounded-3xl p-6 shadow-sm ${
                isBigScreen ? "w-1/3" : "w-full"
              }`}
            >
              <OverviewChart />
            </div>
          </div>
          <div
            className={`flex ${
              !isBigScreen && "flex-col"
            } w-full justify-around mt-12`}
          >
            {/* All Orders */}
            <div
              className={`flex-grow ${
                isBigScreen ? "mr-6" : "mb-6"
              } bg-bgColor-light rounded-3xl p-6 shadow-sm`}
            >
              <AllOrders />
            </div>
            <div
              className={`h-full flex-grow bg-bgColor-light rounded-3xl p-6 shadow-sm ${
                isBigScreen ? "mr-6" : "mb-6"
              }`}
            >
              <AllReviews reviews={reviews} />
            </div>
            {/* Latest Reviews*/}
            <div
              className={`h-full bg-bgColor-light rounded-3xl p-6 shadow-sm ${
                isBigScreen ? "w-1/3" : "w-full"
              }`}
            >
              <LatestReviews />
            </div>
          </div>
          <div
            className={`flex ${
              !isBigScreen && "flex-col"
            } w-full justify-around mt-12`}
          >
            {/* Customer Payments*/}
            <div
              className={`h-full ${
                isBigScreen ? "mr-6" : "mb-6"
              } flex-grow bg-bgColor-light rounded-3xl p-6 shadow-sm`}
            >
              <CustomersPaymentChart />
            </div>
            {/* ActivityOverview */}
            <div
              className={`h-full bg-bgColor-light rounded-3xl p-6 shadow-sm ${
                isBigScreen ? "w-1/3" : "w-full"
              }`}
            >
              <ProductsSold />
            </div>
          </div>

          {/* Top Products */}
          <div className={`flex mt-12 ${!isBigScreen && "flex-col"}`}>
            <div
              className={`bg-bgColor-light rounded-3xl p-6 shadow-sm ${
                isBigScreen ? "w-1/2 mr-8" : "w-full mb-6"
              }`}
            >
              <TopCustomers />
            </div>

            <div className="flex flex-col w-full bg-bgColor-light rounded-3xl p-6 shadow-sm">
              {!isLoading && products !== undefined && (
                <TopProductsTable
                  columns={productsColumns}
                  data={productsData}
                />
              )}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Dashboard;

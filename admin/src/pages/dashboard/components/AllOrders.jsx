import React from "react";
import ReactApexCharts from "react-apexcharts";
import { useState, useEffect } from "react";
import CartIcon from "../../../components/icons/CartIcon";
import { useSelector } from "react-redux";
import moment from "moment";
import { useMemo } from "react";

const AllOrders = () => {
  const { orders } = useSelector((state) => state.orders);

  const getMonthlyOrders = useMemo(
    () => (month) => {
      const result = orders.filter(
        (order) =>
          moment(new Date(order.dateOrdered).getTime()).format("M") === month
      ).length;
      return result;
    },
    [orders]
  );

  const [options, setOptions] = useState({
    chart: {
      height: 100,
      type: "line",
      sparkline: {
        enabled: true,
      },
      toolbar: {
        show: false,
      },
    },
    dataLabels: {
      enabled: false,
    },

    colors: ["#d63384"],

    legend: {
      show: false,
    },
    tooltip: {
      enabled: false,
    },
    grid: {
      show: false,
    },
    stroke: {
      curve: "smooth",
      lineCap: "butt",
    },
    xaxis: {
      show: false,
      lines: {
        show: false,
      },
      labels: {
        show: false,
      },
    },
    yaxis: {
      show: false,
      lines: {
        show: false,
      },
      labels: {
        show: false,
      },
    },
    tooltip: {
      custom: function ({ series, seriesIndex, dataPointIndex, w }) {
        return (
          '<div class="arrow_box bg-customYellow-light py-1 px-4">' +
          "<span class='text-black font-semibold'>" +
          series[seriesIndex][dataPointIndex] +
          "</span>" +
          "</div>"
        );
      },
    },
  });

  const JanOrders = getMonthlyOrders("1");
  const FebOrders = getMonthlyOrders("2");
  const MarOrders = getMonthlyOrders("3");
  const AprOrders = getMonthlyOrders("4");
  const MayOrders = getMonthlyOrders("5");
  const JunOrders = getMonthlyOrders("6");
  const JulOrders = getMonthlyOrders("7");
  const AugOrders = getMonthlyOrders("8");
  const SepOrders = getMonthlyOrders("9");
  const OctOrders = getMonthlyOrders("10");
  const NovOrders = getMonthlyOrders("11");
  const DecOrders = getMonthlyOrders("12");

  const [series, setSeries] = useState([]);

  useEffect(() => {
    setSeries([
      {
        name: "Earning",
        data: [
          JanOrders,
          FebOrders,
          MarOrders,
          AprOrders,
          MayOrders,
          JunOrders,
          JulOrders,
          AugOrders,
          SepOrders,
          OctOrders,
          NovOrders,
          DecOrders,
        ],
      },
    ]);
  }, [
    JanOrders,
    FebOrders,
    MarOrders,
    AprOrders,
    MayOrders,
    JunOrders,
    JulOrders,
    AugOrders,
    SepOrders,
    OctOrders,
    NovOrders,
    DecOrders,
  ]);

  return (
    <div className="flex flex-col justify-between">
      <CartIcon color={"#7176AC9F"} />
      <span className="text-black font-semibold mt-2">All Orders</span>
      <div className="flex items-center justify-between">
        <span className="text-black font-semibold text-xl">
          {orders.length}
        </span>
        <ReactApexCharts
          options={options}
          series={series}
          type="line"
          height={50}
          width={100}
        />
      </div>
      <span className="text-green-300 font-normal">
        {getMonthlyOrders(moment(new Date().getTime()).format("M")) -
          getMonthlyOrders(moment(new Date().getTime()).format("M") - 1)}{" "}
        orders over last month
      </span>
    </div>
  );
};

export default AllOrders;

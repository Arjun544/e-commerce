import moment from "moment";
import React, { useEffect, useState } from "react";
import { useMemo } from "react";
import ReactApexCharts from "react-apexcharts";
import { useSelector } from "react-redux";

const ProductsSold = () => {
  const { orders } = useSelector((state) => state.orders);

  const getYearlyProductsSold = useMemo(
    () => (month) => {
      const productsSold = orders
        .filter(
          (order) =>
            order.status === "Completed" &&
            order.isPaid === true &&
            moment(new Date(order.dateOrdered).getTime()).format("M") === month
        )
        .map((item) => item.orderItems.map((e) => e.quantity))
        .map((c) => c.reduce((a, b) => a + b, 0))
        .reduce((a, b) => a + b, 0);
      return productsSold;
    },
    [orders]
  );

  const [options, setOptions] = useState({
    chart: {
      zoom: {
        enabled: false,
      },
      height: 350,
      type: "line",
      toolbar: {
        show: false,
      },
    },
    colors: ["#3359d6"],
    dataLabels: {
      enabled: false,
    },
    grid: {
      show: false,
    },
    tooltip: {
      enabled: false,
    },
    stroke: {
      curve: "smooth",
      lineCap: "butt",
    },
    xaxis: {
      type: "category",
      axisTicks: {
        show: false,
      },
      axisBorder: {
        show: false,
      },
      labels: {
        hideOverlappingLabels: false,
        style: {
          colors: ['#000'],
          fontSize: "12px",
          fontWeight: 600,
        },
      },
      tickPlacement: "on",
      categories: [
        "Jan",
        "Feb",
        "Mar",
        "Apr",
        "May",
        "Jun",
        "July",
        "Aug",
        "Sept",
        "Oct",
        "Nov",
        "Dec",
      ],
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

  const [series, setSeries] = useState([
    {
      name: "Inflation",
      data: [],
    },
  ]);

  useEffect(() => {
    const JanProductsSold = getYearlyProductsSold("1");
    const FebProductsSold = getYearlyProductsSold("2");
    const MarProductsSold = getYearlyProductsSold("3");
    const AprProductsSold = getYearlyProductsSold("4");
    const MayProductsSold = getYearlyProductsSold("5");
    const JunProductsSold = getYearlyProductsSold("6");
    const JulProductsSold = getYearlyProductsSold("7");
    const AugProductsSold = getYearlyProductsSold("8");
    const SepEarning = getYearlyProductsSold("9");
    const OctProductsSold = getYearlyProductsSold("10");
    const NovProductsSold = getYearlyProductsSold("11");
    const DecProductsSold = getYearlyProductsSold("12");
    setSeries([
      {
        name: "Inflation",
        data: [
          JanProductsSold,
          FebProductsSold,
          MarProductsSold,
          AprProductsSold,
          MayProductsSold,
          JunProductsSold,
          JulProductsSold,
          AugProductsSold,
          SepEarning,
          OctProductsSold,
          NovProductsSold,
          DecProductsSold,
        ],
      },
    ]);
  }, [orders]);

  return (
    <div id="chart" className="flex flex-col">
      <span className="text-black font-semibold text-lg mb-3">
        Products Sold
      </span>
      <ReactApexCharts
        options={options}
        series={series}
        type="bar"
        height={300}
      />
    </div>
  );
};

export default ProductsSold;

import ReactApexCharts from "react-apexcharts";
import { useState, useEffect } from "react";
import { useSelector } from "react-redux";
import moment from "moment";
// 8640

const EarningChart = () => {
  const { orders } = useSelector((state) => state.orders);

  const getMonthlyEarning = (month) => {
    const earnings = orders
      .filter(
        (order) =>
          order.status === "Completed" &&
          order.isPaid === true &&
          moment(new Date(order.dateOrdered).getTime()).format("M") === month
      )
      .map((item) => item.totalPrice)
      .reduce((a, b) => a + b, 0);
    return earnings;
  };

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
    colors: ["#33d6a5"],
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
      labels: {
        hideOverlappingLabels: false,
      },
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
      name: "Earning",
      data: [],
    },
  ]);

  

  useEffect(() => {
    const JanEarning = getMonthlyEarning("1");
    const FebEarning = getMonthlyEarning("2");
    const MarEarning = getMonthlyEarning("3");
    const AprEarning = getMonthlyEarning("4");
    const MayEarning = getMonthlyEarning("5");
    const JunEarning = getMonthlyEarning("6");
    const JulEarning = getMonthlyEarning("7");
    const AugEarning = getMonthlyEarning("8");
    const SepEarning = getMonthlyEarning("9");
    const OctEarning = getMonthlyEarning("10");
    const NovEarning = getMonthlyEarning("11");
    const DecEarning = getMonthlyEarning("12");
    setSeries([
      {
        name: "Earning",
        data: [
          JanEarning,
          FebEarning,
          MarEarning,
          AprEarning,
          MayEarning,
          JunEarning,
          JulEarning,
          AugEarning,
          SepEarning,
          OctEarning,
          NovEarning,
          DecEarning,
        ],
      },
    ]);
  }, [orders]);

  return (
    <div className="flex flex-col">
      <span className="text-black font-semibold text-lg mb-2">Annual Earnings</span>
      <ReactApexCharts
        options={options}
        series={series}
        type="line"
        height={350}
      />
    </div>
  );
};

export default EarningChart;

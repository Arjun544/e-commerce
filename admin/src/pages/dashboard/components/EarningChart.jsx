import ReactApexCharts from "react-apexcharts";
import { useState } from "react";

const EarningChart = () => {
  const [options, setOptions] = useState({
    chart: {
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
      type: "day",
      categories: ["Mon", "Tue", "Wed", "Thur", "Fri", "Sat", "Sun"],
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
      data: [31, 40, 28, 51, 42, 109, 100],
    },
  ]);

  return (
    <div className="flex flex-col">
      <span className="text-black font-semibold text-lg mb-2">Earnings</span>
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

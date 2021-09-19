import ReactApexCharts from "react-apexcharts";
import { useState } from "react";

const EarningChart = () => {
  const [options, setOptions] = useState({
    title: {
      text: " Earning Stats",
    },
    chart: {
      height: 350,
      type: "area",
      toolbar: {
        show: false,
      },
    },
    dataLabels: {
      enabled: false,
    },
    grid: {
      show: false,
    },
    stroke: {
      curve: "smooth",
    },
    xaxis: {
      type: "day",
      categories: ["Mon", "Tue", "Wed", "Thur", "Fri", "Sat", "Sun"],
    },
    tooltip: {
      x: {
        format: "dd/MM/yy HH:mm",
      },
    },
  });
  const [series, setSeries] = useState([
    {
      name: "series1",
      data: [31, 40, 28, 51, 42, 109, 100],
    },
  ]);

  return (
    <ReactApexCharts
      options={options}
      series={series}
      type="area"
      height={350}
    />
  );
};

export default EarningChart;

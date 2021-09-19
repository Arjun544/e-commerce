import ReactApexCharts from "react-apexcharts";
import { useState } from "react";

const OverviewChart = () => {
  const [options, setOptions] = useState({
    chart: {
      width: 300,
      type: "donut",
    },
    dataLabels: {
      enabled: false,
    
    },
    labels: ["Customers", "Product", "Order", "Category"],
    plotOptions: {
      pie: {
        startAngle: -90,
        endAngle: 270,
      },
    },
   
    fill: {
      type: "gradient",
    },
    legend: {
      formatter: function (val, opts) {
        return val + " - " + opts.w.globals.series[opts.seriesIndex];
      },
    },
    title: {
      text: "Business Overview",
    },
    responsive: [
      {
        breakpoint: 480,
        options: {
          chart: {
            width: 200,
          },
          legend: {
            position: "bottom",
          },
        },
      },
    ],
  });
  const [series, setSeries] = useState([44, 55, 41, 17]);

  return (
    <ReactApexCharts
      options={options}
      series={series}
      type="donut"
      height={300}
    />
  );
};

export default OverviewChart;

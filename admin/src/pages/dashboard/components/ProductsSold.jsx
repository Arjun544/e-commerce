import React, { useState } from "react";
import ReactApexCharts from "react-apexcharts";

const ProductsSold = () => {
  const [series, setSeries] = useState([
    {
      name: "Inflation",
      data: [2.3, 3.1, 4.0, 10.1, 4.0, 3.6, 3.2, 2.3, 1.4, 0.8, 0.5, 0.2],
    },
  ]);

  const [options, setOptions] = useState({
    chart: {
      height: 100,
      type: "bar",
      zoom: {
        enabled: false,
      },
      sparkline: {
        enabled: true,
      },
      toolbar: {
        show: false,
      },
    },

    plotOptions: {
      bar: {
        dataLabels: {
          position: "top",
        },
      },
    },
    dataLabels: {
      enabled: true,
      style: {
        colors: ["#333"],
      },
      offsetY: -20,
    },
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
      type: "category",
      categories: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
      
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

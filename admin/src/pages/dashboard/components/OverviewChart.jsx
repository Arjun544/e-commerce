import ReactApexCharts from "react-apexcharts";
import { useState } from "react";

const OverviewChart = () => {
  const [options, setOptions] = useState({
    chart: {
      width: 350,
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
      position: "bottom",
      formatter: function (val, opts) {
        return (
          '<div class="flex-col w-full ml-2">' +
          "<span class='text-black font-semibold text-sm mr-2'>" +
          opts.w.globals.series[opts.seriesIndex] +
          "</span>" +
          "<span class='text-black font-semibold'>" +
          val +
          "</span>"
        );
      },
    },

    responsive: [
      {
        breakpoint: 480,
        options: {
          chart: {
            width: 250,
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
    <div className="flex flex-col w-full h-full">
      <span className="text-black font-semibold text-lg mb-2">Overview</span>
      <div className="flex w-full h-full items-center justify-center">
        <ReactApexCharts
          options={options}
          series={series}
          type="donut"
          height={300}
        />
      </div>
    </div>
  );
};

export default OverviewChart;

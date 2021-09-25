import ReactApexCharts from "react-apexcharts";
import { useState } from "react";

const CustomersPaymentChart = () => {
  const [options, setOptions] = useState({
    chart: {
      width: 300,
      type: "radialBar",
    },
    dataLabels: {
      enabled: false,
    },
    labels: ["Cash", "Card"],
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
            width: 200,
          },
          legend: {
            position: "bottom",
          },
        },
      },
    ],
  });
  const [series, setSeries] = useState([44, 15]);

  return (
    <div className="flex flex-col">
      <span className="text-black font-semibold text-lg mb-2">Overview</span>
      <ReactApexCharts
        options={options}
        series={series}
        type="radialBar"
        height={300}
      />
    </div>
  );
};

export default CustomersPaymentChart;

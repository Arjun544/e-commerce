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
      formatter: function (val, opts) {
        return val + " - " + opts.w.globals.series[opts.seriesIndex];
      },
    },
    title: {
      text: "Customers Payment Methods",
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
    <ReactApexCharts
      options={options}
      series={series}
      type="radialBar"
      height={300}
    />
  );
};

export default CustomersPaymentChart;

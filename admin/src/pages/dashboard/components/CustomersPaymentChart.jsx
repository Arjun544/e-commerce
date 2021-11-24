import ReactApexCharts from "react-apexcharts";
import { useEffect, useState } from "react";
import { useSelector } from "react-redux";

const CustomersPaymentChart = () => {
  const { orders } = useSelector((state) => state.orders);
  const cashOrders = orders.filter((order) => order.payment === "Cash").length;
  const cardOrders = orders.filter((order) => order.payment === "Card").length;

  function percentage(percent, total) {
    return ((percent / 100) * total).toFixed(2);
  }

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
          "k" +
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
  const [series, setSeries] = useState([0, 0]);

  useEffect(() => {
    setSeries([
      percentage(cashOrders, orders.length),
      percentage(cardOrders, orders.length),
    ]);
  }, [cashOrders, cardOrders]);

  return (
    <div className="flex flex-col">
      <span className="text-black font-semibold text-lg mb-2">Payment</span>
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

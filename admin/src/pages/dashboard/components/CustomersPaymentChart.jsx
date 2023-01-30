import ReactApexCharts from "react-apexcharts";
import { useEffect, useState } from "react";
import { useSelector } from "react-redux";

const CustomersPaymentChart = () => {
  const { orders } = useSelector((state) => state.orders);
  const cashOrders = orders.filter((order) => order.payment === "Cash").length;
  const cardOrders = orders.filter((order) => order.payment === "Card").length;

  const [series, setSeries] = useState([cashOrders, cardOrders]);

  useEffect(() => {
    setSeries([cashOrders, cardOrders]);
  }, [cashOrders, cardOrders]);

  const [options] = useState({
    chart: {
      width: 350,
      type: "donut",
    },
    dataLabels: {
      enabled: false,
    },
    labels: ["Cash Orders", "Card Orders"],
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

  return (
    <div className="flex flex-col">
      <span className="text-black font-semibold text-lg mb-2">Payment</span>
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

export default CustomersPaymentChart;

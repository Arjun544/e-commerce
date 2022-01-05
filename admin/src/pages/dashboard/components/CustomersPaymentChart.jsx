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
    series: [42, 47],
    chart: {
      width: 300,
      type: "polarArea",
    },
    dataLabels: {
      enabled: false,
    },
    labels: ["Cash", "Card"],
    plotOptions: {
      polarArea: {
        rings: {
          strokeWidth: 0,
        },
        spokes: {
          strokeWidth: 0,
        },
      },
    },
    legend: {
      position: "bottom",
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
  const [series, setSeries] = useState([
    {
      name: "data",
      data: [0, 0],
    },
  ]);

  useEffect(() => {
    setSeries([
      {
        name: "data",
        data: [42, 47],
      },
    ]);
  }, [cashOrders, cardOrders]);

  return (
    <div className="flex flex-col">
      <span className="text-black font-semibold text-lg mb-2">Payment</span>
      <ReactApexCharts
        options={options}
        series={series}
        type="polarArea"
        height={300}
      />
    </div>
  );
};

export default CustomersPaymentChart;

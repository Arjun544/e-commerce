import ReactApexCharts from "react-apexcharts";
import { useEffect, useState } from "react";
import { useSelector } from "react-redux";

const OverviewChart = () => {
  const { customers } = useSelector((state) => state.customers);
  const { products } = useSelector((state) => state.products);
  const { orders } = useSelector((state) => state.orders);
  const { categories } = useSelector((state) => state.categories);
  const [series, setSeries] = useState([
    customers.length,
    products.length,
    orders.length,
    categories.length,
  ]);
  

  useEffect(() => {
    setSeries([customers.length, products.length, orders.length, categories.length]);
  }, [customers, products, orders, categories]);

  const [options] = useState({
    chart: {
      width: 350,
      type: "donut",
    },
    dataLabels: {
      enabled: false,
    },
    labels: ["Customers", "Products", "Orders", "Categories"],
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

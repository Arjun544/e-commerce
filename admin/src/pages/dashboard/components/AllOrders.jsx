import React from "react";
import ReactApexCharts from "react-apexcharts";
import { useState } from "react";
import CartIcon from "../../../components/icons/CartIcon";

const AllOrders = () => {
  const [options, setOptions] = useState({
    chart: {
      height: 100,
      type: "line",
      sparkline: {
        enabled: true,
      },
      toolbar: {
        show: false,
      },
    },
    dataLabels: {
      enabled: false,
    },
    
      colors: ["#d63384"],
    
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
      width: 4,
      lineCap: "butt",
    },
    xaxis: {
      show: false,
      lines: {
        show: false,
      },
      labels: {
        show: false,
      },
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
    <div className="flex flex-col justify-between">
      <CartIcon />
      <span className="text-black font-semibold text-xl mt-2">Orders</span>
      <div className="flex items-center justify-between">
        <span className="text-black font-semibold text-xl">310</span>
        <ReactApexCharts
          options={options}
          series={series}
          type="line"
          height={50}
          width={80}
        />
      </div>
      <span className="text-green-300 font-normal">Over last month 1.4%</span>
    </div>
  );
};

export default AllOrders;

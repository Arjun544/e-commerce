import React from "react";
import ReactApexCharts from "react-apexcharts";
import { useState } from "react";
import ChatIcon from "../../../components/icons/ChatIcon";
import ReactStars from "react-rating-stars-component";

const CustomerReviews = () => {
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

    colors: ["#33d656"],

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
  const [series, setSeries] = useState([
    {
      name: "series1",
      data: [31, 40, 28, 51, 42, 109, 100],
    },
  ]);

  return (
    <div className="flex flex-col justify-between">
      <ChatIcon />
      <span className="text-black font-semibold text-lg mt-2">Reviews</span>
      <div className="flex items-center justify-between">
        <div className="flex items-center">
          <ReactStars
            classNames="mr-2"
            value={2}
            count={5}
            edit={false}
            size={20}
            isHalf={true}
            emptyIcon={<i className="far fa-star"></i>}
            halfIcon={<i className="fa fa-star-half-alt"></i>}
            fullIcon={<i className="fa fa-star"></i>}
            color="#575757a9"
            activeColor="#ffd700"
          />
          <span className="text-black font-semibold text-sm pt-1 tracking-wider">310</span>
        </div>
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

export default CustomerReviews;

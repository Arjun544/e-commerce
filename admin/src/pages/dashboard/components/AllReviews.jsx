import React, { useEffect } from "react";
import ReactApexCharts from "react-apexcharts";
import { useState } from "react";
import ChatIcon from "../../../components/icons/ChatIcon";
import ReactStars from "react-rating-stars-component";
import { useSelector } from "react-redux";
import moment from "moment";

const AllReviews = ({ reviews }) => {
  const getMonthlyReviews = (month) => {
    const result = reviews.filter(
      (review) =>
        moment(new Date(review.addedAt).getTime()).format("M") === month
    ).length;
    return result;
  };
  //calculating avg rating from all ratings

  const ratings = reviews.map((review) => parseFloat(review.rating));
  const averageRating = ratings.reduce((a, b) => a + b, 0) / ratings.length;

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
  const janReviews = getMonthlyReviews("1");
  const febReviews = getMonthlyReviews("2");
  const marReviews = getMonthlyReviews("3");
  const aprReviews = getMonthlyReviews("4");
  const mayReviews = getMonthlyReviews("5");
  const junReviews = getMonthlyReviews("6");
  const julReviews = getMonthlyReviews("7");
  const augReviews = getMonthlyReviews("8");
  const sepReviews = getMonthlyReviews("9");
  const octReviews = getMonthlyReviews("10");
  const novReviews = getMonthlyReviews("11");
  const decReviews = getMonthlyReviews("12");

  const [series, setSeries] = useState([]);

  useEffect(() => {
    setSeries([
      {
        name: "Reviews",
        data: [
          janReviews,
          febReviews,
          marReviews,
          aprReviews,
          mayReviews,
          junReviews,
          julReviews,
          augReviews,
          sepReviews,
          octReviews,
          novReviews,
          decReviews,
        ],
      },
    ]);
  }, [
    janReviews,
    febReviews,
    marReviews,
    aprReviews,
    mayReviews,
    junReviews,
    julReviews,
    augReviews,
    sepReviews,
    octReviews,
    novReviews,
    decReviews,
  ]);

  return (
    <div className="flex flex-col justify-between">
      <ChatIcon color={"#7176AC9F"} />
      <span className="text-black font-semibold text-lg mt-2">All Reviews</span>
      <div className="flex items-center justify-between">
        <div className="flex items-center">
          <ReactStars
            classNames="mr-2"
            value={averageRating ?? 0}
            count={5}
            edit={false}
            size={25}
            isHalf={true}
            emptyIcon={<i className="far fa-star"></i>}
            halfIcon={<i className="fa fa-star-half-alt"></i>}
            fullIcon={<i className="fa fa-star"></i>}
            color="#575757a9"
            activeColor="#ffd700"
          />
          <span className="text-black font-semibold text-md pt-1 tracking-wider">
            {reviews.length}
          </span>
        </div>
        <ReactApexCharts
          options={options}
          series={series}
          type="line"
          height={50}
          width={100}
        />
      </div>
      <span className="text-green-300 font-normal">Over last month 1.4%</span>
    </div>
  );
};

export default AllReviews;

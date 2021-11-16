import React, { useState, useContext, useEffect } from "react";
import OrdersTable from "../../orders/components/orders_table";
import TableActions from "../../orders/components/table_actions";
import TopBar from "../../../components/TopBar";
import { useSelector } from "react-redux";
import { useLocation } from "react-router";

const FilterOrder = () => {
  const location = useLocation();
  const tableData = location.state.order;

  const data = tableData.map((item) => ({
    order: item,
    date: item.dateOrdered,
    customerName: item.user.username,
    total: item.totalPrice,
    status: item.status,
    payment: item.payment,
    country: item.country,
    deliveryType: item.deliveryType,
    phone: item.phone,
    orderItems: item.orderItems,
  }));

  const columns = [
    {
      Header: "No",
      maxWidth: 10,
      accessor: "",
      Cell: (row) => {
        console.log(row.row);
        return <div>{row.row.index + 1}</div>;
      },
      disableSortBy: true,
      disableFilters: true,
    },
    {
      Header: "Date",
      accessor: "date",
    },
    {
      Header: "Customer Name",
      accessor: "customerName",
    },
    {
      Header: "Payment",
      accessor: "payment",
    },
    {
      Header: "Amount",
      accessor: "total",
    },
    {
      Header: "Delivery",
      accessor: "deliveryType",
    },
    {
      Header: "Phone",
      accessor: "phone",
    },
    {
      Header: "Status",
      accessor: "status",
    },
    {
      Header: "Actions",
      Cell: (props) => <TableActions value={props.cell.value} />,
    },
  ];

  return (
    <div className="flex flex-col w-full h-full overflow-y-auto overflow-x-hidden  bg-white">
      <TopBar />
      <div className="flex flex-col px-10 mt-6">
        <span className="text-black font-semibold text-xl mb-6">
          {(() => {
            switch (location.pathname.split("/")[3]) {
              case "completed":
                break;
              default:
                break;
            }
          })()}
        </span>
        <OrdersTable columns={columns} data={data} />
      </div>
    </div>
  );
};

export default FilterOrder;

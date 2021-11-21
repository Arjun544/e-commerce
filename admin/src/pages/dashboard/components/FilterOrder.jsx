import React, { useState, useContext, useEffect } from "react";
import OrdersTable from "../../orders/components/orders_table";
import TableActions from "../../orders/components/table_actions";
import TopBar from "../../../components/TopBar";
import { useSelector } from "react-redux";
import { useHistory, useLocation } from "react-router";
import { Breadcrumb, Breadcrumbs } from "react-rainbow-components";

const FilterOrder = () => {
  const location = useLocation();
  const history = useHistory();
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
      <div className="flex flex-col px-10">
        <Breadcrumbs className='my-6'>
          <Breadcrumb label="Dashboard" onClick={() => history.goBack()} />
          <Breadcrumb
            label={(() => {
              switch (location.pathname.split("/")[3]) {
                case "completed":
                  return "Completed Orders";
                case "pending":
                  return "Pending Orders";
                case "confirmed":
                  return "Confirmed Orders";
                case "rejected":
                  return "Rejected Orders";
                case "processing":
                  return "Processing Orders";
                case "delivered":
                  return "Delivered Orders";
                case "cancelled":
                  return "Cancelled Orders";
                default:
                  break;
              }
            })()}
          />
        </Breadcrumbs>

        <OrdersTable columns={columns} data={data} />
      </div>
    </div>
  );
};

export default FilterOrder;

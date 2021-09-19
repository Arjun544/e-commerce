import React, { useState, useContext } from "react";
import { AppContext } from "../../App";
import Featured from "./components/featured";
import OnSale from "./components/onSale";
import ProductsTable from "./components/products_table";
import Status from "./components/status";
import { TableActions } from "./components/table_actions";

const Products = () => {
  const { isBigScreen } = useContext(AppContext);

  const data = [
    {
      name: "Test",
      date: Date.now(),
    },
    {
      name: "Test",
      date: Date.now(),
    },
    {
      name: "Test",
      date: Date.now(),
    },
  ];

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
      Header: "Name",
      accessor: "name",
    },
    {
      Header: "Date",
      accessor: "date",
    },
    {
      Header: "Featured",
      Cell: Featured,
    },
    {
      Header: "On Sale",
      Cell: OnSale,
    },
    {
      Header: "Status",
      Cell: Status,
    },
    {
      Header: "Actions",
      Cell: TableActions,
    },
  ];

  return (
    <div className="flex flex-col h-full overflow-y-auto overflow-x-hidden  bg-white px-10">
      {/* Views */}
      <ProductsTable columns={columns} data={data} />
    </div>
  );
};

export default Products;

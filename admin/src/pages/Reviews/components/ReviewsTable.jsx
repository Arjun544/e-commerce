import React, { useContext } from "react";
import moment from "moment";
import {
  useTable,
  useFilters,
  useGlobalFilter,
  useAsyncDebounce,
  useSortBy,
  usePagination,
} from "react-table";
import {
  ChevronDoubleLeftIcon,
  ChevronDoubleRightIcon,
} from "@heroicons/react/solid";
import ArrowLeftIcon from "../../../components/icons/ArrowLeftIcon";
import ArrowRightIcon from "../../../components/icons/ArrowRightIcon";
import { Button, PageButton } from "../../../components/pagination_button";
import {
  SortIcon,
  SortUpIcon,
  SortDownIcon,
} from "../../../components/pagination_icons";
import { useHistory } from "react-router-dom";
import { AppContext } from "../../../App";

// Define a default UI for filtering
function GlobalFilter({
  preGlobalFilteredRows,
  globalFilter,
  setGlobalFilter,
}) {
  const count = preGlobalFilteredRows.length;
  const [value, setValue] = React.useState(globalFilter);
  const onChange = useAsyncDebounce((value) => {
    setGlobalFilter(value || undefined);
  }, 200);

  return (
    <input
      type="text"
      className="rounded-xl py-2 px-10 mt-2 text-white placeholder-white bg-Grey-dark border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
      value={value || ""}
      onChange={(e) => {
        setValue(e.target.value);
        onChange(e.target.value);
      }}
      placeholder={`Search in ${count} reviews...`}
    />
  );
}

function ReviewsTable({
  columns,
  data,
  setCurrentPage,
  currentPage,
  totalPages,
  hasNextPage,
  hasPrevPage,
}) {
  const history = useHistory();
  const { setSelectedSideBar } = useContext(AppContext);
  // Use the state and functions returned from useTable to build your UI
  const {
    getTableProps,
    getTableBodyProps,
    headerGroups,
    prepareRow,
    page,
    state,
    preGlobalFilteredRows,

    setGlobalFilter,
  } = useTable(
    {
      columns,
      data,
    },
    useFilters, // useFilters!
    useGlobalFilter,
    useSortBy,
    usePagination // new
  );

  const onNameClick = (e, id) => {
    e.preventDefault();
    e.stopPropagation();
    setSelectedSideBar(6);
    history.push(`/customers/view/${id}`);
  };

  const onProductClick = (e, id) => {
    e.preventDefault();
    e.stopPropagation();
    setSelectedSideBar(2);
    history.push(`/products/view/${id}`);
  };

  const handleNextPage = (e) => {
    e.preventDefault();
    if (hasNextPage) {
      setCurrentPage((prev) => prev + 1);
    }
  };
  const handlePreviousPage = (e) => {
    e.preventDefault();
    if (hasPrevPage) {
      setCurrentPage((prev) => prev - 1);
    }
  };

  // Render the UI for your table
  return (
    <div>
      <div className=" sm:flex sm:gap-x-2">
        <GlobalFilter
          preGlobalFilteredRows={preGlobalFilteredRows}
          globalFilter={state.globalFilter}
          setGlobalFilter={setGlobalFilter}
        />
        {headerGroups.map((headerGroup) =>
          headerGroup.headers.map((column) =>
            column.Filter ? (
              <div className="mt-2 sm:mt-0" key={column.id}>
                {column.render("Filter")}
              </div>
            ) : null
          )
        )}
      </div>
      {/* table */}
      <div className="mt-4 flex flex-col">
        <div className="-my-2 overflow-x-auto -mx-4 sm:-mx-6 lg:-mx-8">
          <div className="py-2 align-middle inline-block min-w-full sm:px-6 lg:px-8">
            <div className="">
              <table {...getTableProps()} className="min-w-full">
                <thead className="bg-white">
                  {headerGroups.map((headerGroup) => (
                    <tr {...headerGroup.getHeaderGroupProps()}>
                      {headerGroup.headers.map((column) => (
                        // Add the sorting props to control sorting. For this example
                        // we can add them into the header props
                        <th
                          scope="col"
                          className="group px-6 py-3 text-left text-xs font-bold text-black uppercase tracking-wider"
                          {...column.getHeaderProps(
                            column.getSortByToggleProps()
                          )}
                        >
                          <div className="flex items-center justify-between">
                            {column.render("Header")}
                            {/* Add a sort direction indicator */}
                            <span>
                              {column.isSorted ? (
                                column.isSortedDesc ? (
                                  <SortDownIcon className="w-4 h-4 text-gray-400" />
                                ) : (
                                  <SortUpIcon className="w-4 h-4 text-gray-400" />
                                )
                              ) : (
                                <SortIcon className="w-4 h-4 text-gray-400 opacity-0 group-hover:opacity-100" />
                              )}
                            </span>
                          </div>
                        </th>
                      ))}
                    </tr>
                  ))}
                </thead>
                <tbody {...getTableBodyProps()} className="bg-white">
                  <div className="flex"></div>
                  {page.map((row, i) => {
                    // new
                    prepareRow(row);
                    return (
                      <tr
                        className={`bg-white shadow-md hover:bg-gray-100 text-gray-500 text-sm font-semibold`}
                        {...row.getRowProps()}
                      >
                        {row.cells.map((cell) => {
                          return (
                            <td
                              {...cell.getCellProps()}
                              className="px-6 py-4 whitespace-nowrap font-semibold"
                              role="cell"
                            >
                              {cell.column.Cell.name === "defaultRenderer" ? (
                                <div
                                  onClick={(e) => {
                                    if (cell.column.Header === "Product") {
                                      onProductClick(
                                        e,
                                        cell.row.original.review.product._id
                                      );
                                    } else if (
                                      cell.column.Header === "Customer"
                                    ) {
                                      onNameClick(
                                        e,
                                        cell.row.original.review.user._id
                                      );
                                    }
                                  }}
                                  className={`text-sm font-semibold  ${(() => {
                                    if (
                                      cell.column.Header === "Customer" ||
                                      cell.column.Header === "Product"
                                    )
                                      return "text-green-500 cursor-pointer";
                                    else {
                                      return "text-gray-500";
                                    }
                                  })()}`}
                                >
                                  {cell.column.Header === "Date"
                                    ? moment(cell.value).format("ll")
                                    : cell.render("Cell")}
                                </div>
                              ) : (
                                cell.render("Cell")
                              )}
                            </td>
                          );
                        })}
                      </tr>
                    );
                  })}
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
      {/* Pagination */}
      <div className="flex items-center justify-between my-6 gap-2">
        <div className="flex items-center gap-2">
          <span className="text-gray-700">Page</span>
          <span className="text-black font-bold">{currentPage}</span>
          <span className="text-gray-700">of</span>
          <span className="text-black font-bold">{totalPages}</span>
        </div>
        <div className="flex items-center gap-3">
          <button
            onClick={() => setCurrentPage(1)}
            className={`${
              currentPage !== 1
                ? "bg-black"
                : "bg-gray-300 hover:cursor-not-allowed"
            } h-10 w-24 rounded-md text-sm text-white font-semibold tracking-wider transform hover:scale-105 transition-all duration-500 ease-in-out`}
          >
            First Page
          </button>
          <button
            onClick={(e) => handlePreviousPage(e)}
            className={`${
              hasPrevPage
                ? "bg-customYellow-light"
                : "bg-gray-300 hover:cursor-not-allowed"
            } h-10 w-24 rounded-md text-sm text-white font-semibold tracking-wider transform hover:scale-105 transition-all duration-500 ease-in-out`}
          >
            Previous
          </button>
          <button
            onClick={(e) => handleNextPage(e)}
            className={`${
              hasNextPage
                ? "bg-customYellow-light"
                : "bg-gray-300 hover:cursor-not-allowed"
            } h-10 w-24 rounded-md text-sm text-white font-semibold tracking-wider transform hover:scale-105 transition-all duration-500 ease-in-out`}
          >
            Next
          </button>
          <button
            onClick={() => setCurrentPage(totalPages)}
            className={`${
              currentPage < totalPages
                ? "bg-black"
                : "bg-gray-300 hover:cursor-not-allowed"
            } h-10 w-24 rounded-md text-sm text-white font-semibold tracking-wider transform hover:scale-105 transition-all duration-500 ease-in-out`}
          >
            Last Page
          </button>
        </div>
      </div>
    </div>
  );
}

export default ReviewsTable;

import React from "react";
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

// Define a default UI for filtering
function GlobalFilter({
  preGlobalFilteredRows,
  globalFilter,
  setGlobalFilter,
}) {
  const history = useHistory();
  const count = preGlobalFilteredRows.length;
  const [value, setValue] = React.useState(globalFilter);
  const onChange = useAsyncDebounce((value) => {
    setGlobalFilter(value || undefined);
  }, 200);

  return (
    <div className="w-full flex justify-between items-center pt-3">
      <input
        type="text"
        className="rounded-xl py-2 px-10 mt-2 text-white placeholder-white bg-Grey-dark border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
        value={value || ""}
        onChange={(e) => {
          setValue(e.target.value);
          onChange(e.target.value);
        }}
        placeholder={`Search in ${count} products...`}
      />
      <div
        onClick={(e) => {
          e.preventDefault();
          history.push("/products/add");
        }}
        className="flex h-12 w-40 bg-customYellow-light rounded-2xl cursor-pointer items-center justify-center transform hover:scale-95 transition duration-500 ease-in-out"
      >
        <span className="text-white font-semibold">Add product</span>
      </div>
    </div>
  );
}

function ProductsTable({ columns, data }) {
  const history = useHistory();
  // Use the state and functions returned from useTable to build your UI
  const {
    getTableProps,
    getTableBodyProps,
    headerGroups,
    prepareRow,
    page, // Instead of using 'rows', we'll use page,
    // which has only the rows for the active page

    // The rest of these things are super handy, too ;)
    canPreviousPage,
    canNextPage,
    pageOptions,
    pageCount,
    gotoPage,
    nextPage,
    previousPage,
    setPageSize,
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

  const onProductClick = (e, product) => {
    e.preventDefault();
    e.stopPropagation();
    history.push(`/products/view/${product.id}`);
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
                                  onClick={(e) =>
                                   {cell.column.Header === "Name" &&
                                     onProductClick(
                                       e,
                                       cell.row.original.product
                                     );}
                                  }
                                  className={`text-sm font-semibold  ${(() => {
                                    if (cell.column.Header === "Name")
                                      return "text-green-500 cursor-pointer";
                                    if (cell.value === "Cash")
                                      return "text-red-500";
                                    if (cell.value === "Card")
                                      return "text-green-500";
                                    if (cell === "Pending")
                                      return "text-customYellow-light";
                                    if (cell.value === "Confirmed")
                                      return "text-green-500";
                                    if (cell.value === "Delivered")
                                      return "text-green-500";
                                    if (cell.value === "Cancelled")
                                      return "text-red-500";
                                    if (cell.value === "Express")
                                      return "text-green-500";
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
      <div className="py-3 flex items-center justify-between">
        <div className="flex-1 flex justify-between sm:hidden">
          <Button onClick={() => previousPage()} disabled={!canPreviousPage}>
            Previous
          </Button>
          <Button onClick={() => nextPage()} disabled={!canNextPage}>
            Next
          </Button>
        </div>
        <div className="hidden sm:flex-1 sm:flex sm:items-center sm:justify-between">
          <div className="flex gap-x-2 items-baseline">
            <span className="text-sm text-gray-700">
              Page <span className="font-medium">{state.pageIndex + 1}</span> of{" "}
              <span className="font-medium">{pageOptions.length}</span>
            </span>
            <label>
              <select
                className="mt-1 block w-full cursor-pointer bg-Grey-dark px-4 text-black font-semibold text-sm rounded-md border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
                value={state.pageSize}
                onChange={(e) => {
                  setPageSize(Number(e.target.value));
                }}
              >
                {[5, 10, 20].map((pageSize) => (
                  <option key={pageSize} value={pageSize}>
                    Show {pageSize}
                  </option>
                ))}
              </select>
            </label>
          </div>

          <nav
            className="relative z-0 inline-flex rounded-md shadow-sm -space-x-px"
            aria-label="Pagination"
          >
            <PageButton
              className="rounded-l-md"
              onClick={() => gotoPage(0)}
              disabled={!canPreviousPage}
            >
              <span className="sr-only">First</span>
              <ChevronDoubleLeftIcon
                className="h-5 w-5 text-gray-400"
                aria-hidden="true"
              />
            </PageButton>
            <PageButton
              onClick={() => previousPage()}
              disabled={!canPreviousPage}
            >
              <span className="sr-only">Previous</span>
              <ArrowLeftIcon color={"#888888"} />
            </PageButton>
            <PageButton onClick={() => nextPage()} disabled={!canNextPage}>
              <span className="sr-only">Next</span>
              <ArrowRightIcon color={"#888888"} />
            </PageButton>
            <PageButton
              className="rounded-r-md"
              onClick={() => gotoPage(pageCount - 1)}
              disabled={!canNextPage}
            >
              <span className="sr-only">Last</span>
              <ChevronDoubleRightIcon
                className="h-5 w-5 text-gray-400"
                aria-hidden="true"
              />
            </PageButton>
          </nav>
        </div>
      </div>
    </div>
  );
}

export default ProductsTable;

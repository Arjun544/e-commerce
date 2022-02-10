import React, { useContext, useEffect, useState } from "react";
import { AppContext } from "../../App";
import TableActions from "./components/TableActions";
import TopBar from "../../components/TopBar";
import { useDispatch } from "react-redux";
import Loader from "react-loader-spinner";
import { getUsers } from "../../api/userApi";
import CustomersTable from "./components/CustomersTable";
import { Avatar } from "./components/Avatar";

const Customers = () => {
  const dispatch = useDispatch();
  const [isLoading, setIsLoading] = useState(false);
  const [currentPage, setCurrentPage] = useState(1);
  const [tableData, setTableData] = useState({});
  const { isBigScreen } = useContext(AppContext);
  useEffect(() => {
    const fetchUsers = async () => {
      try {
        setIsLoading(true);
        const { data } = await getUsers(currentPage, 10, true);
        setTableData(data);
        setIsLoading(false);
      } catch (error) {
        setIsLoading(false);
        console.log(error.response);
      }
    };
    fetchUsers();
  }, [currentPage]);

  const data =
    !isLoading &&
    tableData.results !== undefined &&
    tableData?.results.map((item) => ({
      review: item,
      image: item.profile.image,
      name: item.username,
      email: item.email,
      date: item.createdAt,
    }));

  const columns = [
    {
      Header: "No",
      maxWidth: 10,
      accessor: "",
      Cell: (row) => {
        return <div>{row.row.index + 1}</div>;
      },
      disableSortBy: true,
      disableFilters: true,
    },
    {
      Header: "Image",
      accessor: "image",
      Cell: (props) =>
        props.cell.value ? (
          <img
            className="h-12 w-12 rounded-full object-cover"
            src={props.cell.value}
            alt=""
          />
        ) : (
          <img
            className="h-12 w-12 rounded-full object-cover"
            src="https://schooloflanguages.sa.edu.au/wp-content/uploads/2017/11/placeholder-profile-sq.jpg"
            alt=""
          />
        ),
    },
    {
      Header: "Name",
      accessor: "name",
    },
    {
      Header: "Email",
      accessor: "email",
    },
    {
      Header: "Date Created",
      accessor: "date",
    },

    {
      Header: "Actions",
      Cell: (props) => (
        <TableActions
          user={props.cell.row.original.user}
          setTableData={setTableData}
        />
      ),
    },
  ];

  return (
    <div className="flex flex-col w-full h-full overflow-y-auto overflow-x-hidden  bg-white">
      <TopBar />
      {/* Views */}
      {isLoading ? (
        <div className="flex w-full h-screen items-center justify-center bg-white">
          <Loader
            type="Puff"
            color="#00BFFF"
            height={50}
            width={50}
            timeout={3000} //3 secs
          />
        </div>
      ) : (
        <div className="px-10">
          {!isLoading && tableData.results !== undefined && (
            <CustomersTable
              columns={columns}
              data={data}
              setCurrentPage={setCurrentPage}
              currentPage={currentPage}
              totalPages={tableData.total_pages}
              hasNextPage={tableData.hasNextPage}
              hasPrevPage={tableData.hasPrevPage}
            />
          )}
        </div>
      )}
    </div>
  );
};

export default Customers;

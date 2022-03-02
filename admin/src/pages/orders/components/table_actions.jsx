import React from 'react'
import { Link } from 'react-router-dom'

const TableActions = ({ order }) => {
  return (
    <Link to={`/orders/view/${order.id}`}>
      <button className="bg-green-500 px-3 py-1 text-white font-semibold rounded-md">
        Update Status
      </button>
    </Link>
  );
};

export default TableActions
import EditIcon from "../../../components/icons/EditIcon";
import DeleteIcon from "../../../components/icons/DeleteIcon";

export function TableActions() {
  return (
    <div className="flex">
      <EditIcon className="mr-2 h-5 w-5 cursor-pointer fill-grey hover:fill-green" />
      <DeleteIcon className="cursor-pointer h-5 w-5 fill-grey hover:fill-red" />
    </div>
  );
}

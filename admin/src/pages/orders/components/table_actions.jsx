import EyeIcon from "../../../components/icons/EyeIcon";
import InvoiceIcon from "../../../components/icons/InvoiceIcon";

export function TableActions() {
  return (
    <div className="flex">
      <EyeIcon className="mr-2 cursor-pointer fill-grey hover:fill-green" />
      <InvoiceIcon className="cursor-pointer fill-grey hover:fill-green" />
    </div>
  );
}

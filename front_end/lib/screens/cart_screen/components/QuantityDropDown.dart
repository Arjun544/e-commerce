
import 'package:flutter/material.dart';
import '../../../controllers/cart_screen_controller.dart';
import '../../../models/cart_model.dart';
import '../../../utils/colors.dart';

class QuantityDropDown extends StatefulWidget {
  final CartScreenController cartScreenController;
  final CartProduct item;

  const QuantityDropDown(
      {Key? key, required this.cartScreenController, required this.item})
      : super(key: key);

  @override
  _QuantityDropDownState createState() => _QuantityDropDownState();
}

class _QuantityDropDownState extends State<QuantityDropDown> {
  int quantity = 0;
  @override
  void initState() {
    quantity = widget.item.quantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () async {
            if (quantity < 5) {
              await widget.cartScreenController.updateQuantity(
                productId: widget.item.id,
                value: widget.item.quantity + 1,
              );

              quantity++;

              int total;
              total = widget.item.discount > 0
                  ? widget.item.totalPrice * widget.item.quantity
                  : widget.item.price * widget.item.quantity;
              widget.cartScreenController.cartTotal.value += total;
              widget.cartScreenController.isOrderItemsSelected.value = false;
              widget.cartScreenController.orderItems.clear();
              setState(() {});
            }
          },
          child: const Icon(
            Icons.add_rounded,
            size: 20,
          ),
        ),
        Container(
          width: 30,
          height: 30,
          margin: const EdgeInsets.symmetric(vertical: 6),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: customYellow,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            quantity.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        InkWell(
          onTap: () async {
            if (quantity != 1) {
              await widget.cartScreenController.updateQuantity(
                productId: widget.item.id,
                value: widget.item.quantity - 1,
              );
              quantity--;

              int total;
              total = widget.item.discount > 0
                  ? widget.item.totalPrice * widget.item.quantity
                  : widget.item.price * widget.item.quantity;
              widget.cartScreenController.cartTotal.value -= total;
              widget.cartScreenController.isOrderItemsSelected.value = false;
              widget.cartScreenController.orderItems.clear();
              setState(() {});
            }
          },
          child: const Icon(
            Icons.remove_rounded,
            size: 20,
          ),
        ),
      ],
    );
  }
}
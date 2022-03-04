
import 'package:flutter/material.dart';
import '../../../controllers/cart_screen_controller.dart';
import '../../../models/cart_model.dart';
import 'package:get/get_rx/get_rx.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 6),
          child: DropdownButton<int>(
            value: widget.item.quantity,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black87),
            isExpanded: true,
            iconEnabledColor: Colors.black,
            items: <int>[1, 2, 3, 4, 5].map((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text(value.toString()),
              );
            }).toList(),
            onChanged: (value) async {
              await widget.cartScreenController.updateQuantity(
                productId: widget.item.id,
                value: value!,
              );

              RxList total = [].obs;

              total.add(widget.item.discount > 0
                  ? widget.item.totalPrice * value
                  : widget.item.price * value);

              setState(() {
                widget.item.quantity = value;
                widget.cartScreenController.cartTotal.value = total[0];
                widget.cartScreenController.isOrderItemsSelected.value = false;
                widget.cartScreenController.orderItems.clear();
              });
            },
          ),
        ),
      ),
    );
  }
}

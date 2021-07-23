import 'package:flutter/material.dart';
import '../../../controllers/cart_screen_controller.dart';
import '../../../models/cart_model.dart';

class DropDown extends StatefulWidget {
  final CartScreenController cartScreenController;
  final CartItem item;

  const DropDown({required this.cartScreenController, required this.item});

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
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
              newQuantity: value!,
            );

            setState(() {
              widget.cartScreenController.socket.on('updatedCart', (data) {
                widget.item.quantity = data['quantity'];
                widget.cartScreenController.cartTotal.value =
                    data['totalGrand'];
              });
              widget.item.quantity = value;
            });
          },
        ),
      ),
    );
  }
}

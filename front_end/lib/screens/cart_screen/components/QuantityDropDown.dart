import 'dart:developer';

import 'package:counter_button/counter_button.dart';
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
    return Row(
      children: [
        InkWell(
          onTap: () async {
            if (widget.item.quantity > 1) {
              widget.item.quantity--;
              await widget.cartScreenController.updateQuantity(
                productId: widget.item.id,
                value: widget.item.quantity,
              );

              setState(() {
                RxList<int> total = <int>[].obs;

                total.add(widget.item.discount > 0
                    ? widget.item.totalPrice
                    : widget.item.price);

                log(total.toString());
                widget.cartScreenController.cartTotal.value -= total[0];
                widget.cartScreenController.isOrderItemsSelected.value = false;
                widget.cartScreenController.orderItems.clear();
              });
            }
          },
          child: const Icon(
            Icons.remove_rounded,
            color: Colors.red,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            widget.item.quantity.toString(),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        InkWell(
          onTap: () async {
            if (widget.item.quantity < 5) {
              widget.item.quantity++;
              await widget.cartScreenController.updateQuantity(
                productId: widget.item.id,
                value: widget.item.quantity,
              );

              setState(() {
                RxList<int> total = <int>[].obs;

                total.add(widget.item.discount > 0
                    ? widget.item.totalPrice
                    : widget.item.price);

                log(total.toString());
                widget.cartScreenController.cartTotal.value += total[0];
                widget.cartScreenController.isOrderItemsSelected.value = false;
                widget.cartScreenController.orderItems.clear();
              });
            }
          },
          child: const Icon(
            Icons.add,
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}

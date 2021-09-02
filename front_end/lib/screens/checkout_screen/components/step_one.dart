import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:front_end/widgets/custom_button.dart';
import '../../../models/delivery_model.dart';
import '../../../controllers/checkout_screen_controller.dart';
import '../../../utils/colors.dart';
import 'package:get/get.dart';

class StepOne extends StatefulWidget {
  @override
  _StepOneState createState() => _StepOneState();
}

class _StepOneState extends State<StepOne> {
  final CheckoutScreenController checkoutScreenController = Get.find();

  @override
  void initState() {
    //Calculating total price of order items
    checkoutScreenController.orderItemsPrices =
        checkoutScreenController.orderItems.map((element) {
      var item = element.product.discount > 0
          ? element.product.totalPrice * element.quantity
          : element.product.price * element.quantity;
      return item;
    }).toList();
    checkoutScreenController.subTotal =
        checkoutScreenController.orderItemsPrices.reduce((a, b) => a + b);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Order Confirmation',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              itemCount: checkoutScreenController.orderItems.length,
              itemBuilder: (context, index) {
                return Container(
                  width: Get.width * 0.7,
                  margin: const EdgeInsets.only(top: 30, right: 10),
                  padding: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                      color: customGrey,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: CachedNetworkImage(
                              imageUrl: checkoutScreenController
                                  .orderItems[index].product.image,
                              fit: BoxFit.cover,
                              width: Get.width * 0.15,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                checkoutScreenController
                                    .orderItems[index].product.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              checkoutScreenController
                                          .orderItems[index].product.discount >
                                      0
                                  ? Text(
                                      '\$ ${checkoutScreenController.orderItems[index].product.totalPrice.toString()}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    )
                                  : Text(
                                      '\$ ${checkoutScreenController.orderItems[index].product.price.toString()}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        'x ${checkoutScreenController.orderItems[index].quantity.toString()}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ],
                  ),
                );
              }),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Delivery Options',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: deliveryOptions.length,
                  padding: const EdgeInsets.only(top: 20),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: customGrey,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Obx(
                                () => Checkbox(
                                  value: index ==
                                          checkoutScreenController
                                              .selectedDelivery.value
                                      ? true
                                      : false,
                                  activeColor: customYellow,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  onChanged: (value) {
                                    checkoutScreenController
                                        .selectedDelivery.value = index;
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        deliveryOptions[index].img,
                                        fit: BoxFit.cover,
                                        width: Get.width * 0.1,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        deliveryOptions[index].name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        deliveryOptions[index].days,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                      const Text(
                                        ' business days',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                            fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Text(
                              '\$${deliveryOptions[index].price}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
        Container(
          height: Get.height * 0.29,
          width: Get.width,
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
          decoration: BoxDecoration(
            color: customGrey,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                blurRadius: 4.0,
                offset: const Offset(1, 0),
              ),
            ],
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Subtotal',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 16),
                  ),
                  Text(
                    checkoutScreenController.subTotal.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Delivery fees',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 16),
                  ),
                  Obx(
                    () => Text(
                      deliveryOptions[
                              checkoutScreenController.selectedDelivery.value]
                          .price
                          .toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 16),
                  ),
                  Obx(
                    () => Text(
                      (checkoutScreenController.subTotal +
                              deliveryOptions[checkoutScreenController
                                      .selectedDelivery.value]
                                  .price)
                          .toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                ],
              ),
              CustomButton(
                height: 50,
                width: Get.width * 0.7,
                text: 'Continue',
                color: darkBlue,
                onPressed: () {
                  checkoutScreenController.activeStep.value += 1;
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

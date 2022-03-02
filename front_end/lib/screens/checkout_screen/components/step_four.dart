import 'package:flutter/material.dart';
import 'package:front_end/controllers/root_screen_controller.dart';
import 'package:front_end/models/userModel.dart';
import '../../../controllers/cart_screen_controller.dart';
import '../../../controllers/checkout_screen_controller.dart';
import '../../../models/delivery_model.dart';
import '../../../utils/colors.dart';
import '../../../widgets/custom_button.dart';
import 'package:get/get.dart';

class StepFour extends StatelessWidget {
  final CheckoutScreenController checkoutScreenController = Get.find();
  final CartScreenController cartScreenController = Get.find();
  final RootScreenController rootScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Order Overview',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Container(
          width: Get.width,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 24),
          decoration: BoxDecoration(
            color: customGrey,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                blurRadius: 4.0,
                offset: const Offset(1, 0),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Items',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        'City',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        'Country',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        'Phone',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        'Delivery',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        'Payment',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        'Delivery Fee',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        'Address',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'x${checkoutScreenController.order['items']}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        checkoutScreenController.order['city'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        checkoutScreenController.order['country'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        checkoutScreenController.order['phone'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        checkoutScreenController.order['delivery'] == 0
                            ? 'Free'
                            : 'Express',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        checkoutScreenController.order['payment'] == 0
                            ? 'Cash'
                            : 'Card',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        checkoutScreenController.order['deliveryFees']
                            .toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        checkoutScreenController.order['shippingAddress'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: Get.height * 0.35,
          width: Get.width,
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          decoration: BoxDecoration(
            color: customGrey,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                blurRadius: 4.0,
                offset: const Offset(1, 0),
              ),
            ],
            borderRadius: BorderRadius.circular(20),
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
                      fontSize: 16,
                    ),
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
              const SizedBox(
                height: 20,
              ),
              StreamBuilder<UserModel>(
                  stream:
                      rootScreenController.currentUserStreamController.stream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox();
                    } else if (snapshot.data == null) {}
                    UserModel? currentUser = snapshot.data;
                    return CustomButton(
                      height: 50,
                      width: Get.width * 0.7,
                      text: 'Pay',
                      color: darkBlue,
                      onPressed: () => checkoutScreenController.orderPay(
                          context, currentUser!),
                    );
                  }),
            ],
          ),
        ),
      ],
    );
  }
}

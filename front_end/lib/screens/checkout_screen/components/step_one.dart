import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../controllers/checkout_screen_controller.dart';
import '../../../utils/colors.dart';
import 'package:get/get.dart';

class StepOne extends StatelessWidget {
  StepOne({Key? key}) : super(key: key);

  final CheckoutScreenController checkoutScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Text(
            'Order Confirmation',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: checkoutScreenController.orderItems.length,
              itemBuilder: (context, index) {
                return Container(
                  height: Get.height * 0.1,
                  width: Get.width * 0.8,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: customGrey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: checkoutScreenController
                              .orderItems[index].product.image,
                          fit: BoxFit.cover,
                          width: Get.width * 0.2,
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
                          Text(
                            '\$ ${checkoutScreenController.orderItems[index].product.price.toString()}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:front_end/controllers/checkout_screen_controller.dart';
import 'package:front_end/utils/colors.dart';
import 'package:get/get.dart';

class StepThree extends StatelessWidget {
  final CheckoutScreenController checkoutScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Payment',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: 2,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            itemBuilder: (context, index) {
              return Container(
                height: 60,
                width: Get.width * 0.8,
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: customGrey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Obx(
                      () => Radio(
                        activeColor: customYellow,
                        toggleable: true,
                        value: index == 0 ? 0 : 1,
                        groupValue:
                            checkoutScreenController.selectedPayment.value,
                        onChanged: (value) async {
                          checkoutScreenController.selectedPayment.value =
                              index;
                        },
                      ),
                    ),
                    index == 0
                        ? const Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              'Cash On Delivery',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          )
                        : Image.asset(
                            'assets/Stripe.png',
                            fit: BoxFit.cover,
                            width: Get.width * 0.2,
                          ),
                  ],
                ),
              );
            }),
      ],
    );
  }
}

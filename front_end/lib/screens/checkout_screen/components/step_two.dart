import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:front_end/controllers/profile_screen_controller.dart';
import 'package:front_end/screens/profile_screen/components/shipping_address.dart';
import '../../../controllers/checkout_screen_controller.dart';
import '../../../utils/colors.dart';
import '../../../widgets/custom_button.dart';
import '../../../controllers/root_screen_controller.dart';
import '../../../models/userModel.dart';
import '../../../widgets/address_widget.dart';
import 'package:get/get.dart';

class StepTwo extends StatelessWidget {
  final RootScreenController rootScreenController = Get.find();
  final CheckoutScreenController checkoutScreenController = Get.find();
  final ProfileScreenController profileScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Shipping Address',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: StreamBuilder<UserModel>(
              stream: rootScreenController.currentUserStreamController.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox();
                } else if (snapshot.data == null) {}
                UserModel? currentUser = snapshot.data;
                return Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.to(
                          () => ShippingAddress(),
                        );
                      },
                      child: const Text(
                        'Add / Edit Address',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 15),
                    AddressWidget(
                      isOrdering: true,
                      currentUser: currentUser,
                    ),
                    CustomButton(
                      height: 50,
                      width: Get.width * 0.7,
                      text: 'Continue',
                      color: darkBlue,
                      onPressed: () {
                        // log(currentUser!
                        //     .data
                        //     .shippingAddress[profileScreenController
                        //         .selectedShippingAddress.value]
                        //     .address
                        //     .toString());
                        checkoutScreenController.activeStep.value += 1;
                      },
                    ),
                  ],
                );
              }),
        ),
      ],
    );
  }
}

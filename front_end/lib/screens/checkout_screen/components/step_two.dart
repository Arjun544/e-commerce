
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../controllers/checkout_screen_controller.dart';
import '../../../controllers/profile_screen_controller.dart';
import '../../../controllers/root_screen_controller.dart';
import '../../../models/userModel.dart';
import '../../../utils/colors.dart';
import '../../../widgets/address_widget.dart';
import '../../../widgets/custom_button.dart';
import '../../profile_screen/components/shipping_address.dart';

class StepTwo extends StatelessWidget {
  final CheckoutScreenController checkoutScreenController;

  StepTwo({required this.checkoutScreenController});

  final RootScreenController rootScreenController = Get.find();
  final ProfileScreenController profileScreenController = Get.find();

  void onContinuePressed(UserModel? currentUser) {
    if (currentUser!.data.shippingAddress.isEmpty) {
      EasyLoading.showToast(
        'Select an address',
        toastPosition: EasyLoadingToastPosition.top,
        maskType: EasyLoadingMaskType.clear,
      );
    } else {
      checkoutScreenController.activeStep.value += 1;
      checkoutScreenController.order['shippingAddress'] = currentUser
          .data
          .shippingAddress[
              profileScreenController.selectedShippingAddress.value]
          .address;
      checkoutScreenController.order['city'] = currentUser
          .data
          .shippingAddress[
              profileScreenController.selectedShippingAddress.value]
          .city;
      checkoutScreenController.order['shippingAddress'] = currentUser
          .data
          .shippingAddress[
              profileScreenController.selectedShippingAddress.value]
          .address;
      checkoutScreenController.order['country'] = currentUser
          .data
          .shippingAddress[
              profileScreenController.selectedShippingAddress.value]
          .country;
      checkoutScreenController.order['phone'] = currentUser
          .data
          .shippingAddress[
              profileScreenController.selectedShippingAddress.value]
          .phone;
    }
  }

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
                          () => ShipAddress(),
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
                    //  SizedBox(height: Get.height*0.15),
                    CustomButton(
                      height: 50,
                      width: Get.width * 0.7,
                      text: 'Continue',
                      color: darkBlue,
                      onPressed: () => onContinuePressed(currentUser),
                    ),
                  ],
                );
              }),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../controllers/cart_screen_controller.dart';
import '../../checkout_screen/checkout_screen.dart';
import '../../../utils/colors.dart';
import 'package:get/get.dart';
import '../../../widgets/social_btn.dart';

class TotalCounter extends StatelessWidget {
  final CartScreenController cartScreenController;

  const TotalCounter({Key? key, required this.cartScreenController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return cartScreenController.cartProducts.value.products.isEmpty
        ? const SizedBox.shrink()
        : Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            margin: const EdgeInsets.only(right: 20, left: 20, bottom: 10),
            decoration: BoxDecoration(
              color: darkBlue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Text(
                    cartScreenController.isOrderItemsSelected.value
                        ? '${cartScreenController.orderItemsTotal.value.toString()}'
                        : '${cartScreenController.cartTotal.value.toString()}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                ),
                Obx(() => SocialButton(
                      height: 45,
                      width: Get.width * 0.4,
                      text: 'Check out',
                      icon: 'assets/images/Logout.svg',
                      color: cartScreenController.orderItems.isNotEmpty
                          ? customYellow
                          : Colors.grey.withOpacity(0.5),
                      iconColor: Colors.white,
                      onPressed: () {
                        cartScreenController.orderItems.isNotEmpty
                            ? Get.to(
                                () => CheckoutScreen(),
                              )
                            : EasyLoading.showToast(
                                'Select items to check out',
                                toastPosition: EasyLoadingToastPosition.top,
                                maskType: EasyLoadingMaskType.clear,
                              );
                      },
                    )),
              ],
            ),
          );
  }
}

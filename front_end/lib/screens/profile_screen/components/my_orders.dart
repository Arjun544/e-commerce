import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front_end/utils/constants.dart';
import '../../../widgets/customDialogue.dart';
import 'review_orders.dart';
import 'track_order.dart';
import '../../../utils/colors.dart';
import 'package:get/get.dart';

import 'cancellation_orders.dart';
import 'receive_orders.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => getStorage.read('isLogin') == true
                      ? Get.to(
                          () => const ReceiveOrders(),
                        )
                      : AccessDialogue(context),
                  child: Container(
                    height: Get.height * 0.13,
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: customGrey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/fast-delivery.png',
                          height: 45,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'To Receive',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => getStorage.read('isLogin') == true
                      ? Get.to(
                          () => const ReviewOrders(),
                        )
                      : AccessDialogue(context),
                  child: Container(
                    height: Get.height * 0.13,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: customGrey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/Chat.svg',
                          color: darkBlue,
                          height: 35,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'To Review',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => getStorage.read('isLogin') == true
                      ? Get.to(
                          () => const CancellationOrders(),
                        )
                      : AccessDialogue(context),
                  child: Container(
                    height: Get.height * 0.13,
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: customGrey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/Paper Fail.svg',
                          color: Colors.red,
                          height: 35,
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Cancellations',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => getStorage.read('isLogin') == true
                      ? Get.to(
                          () => const TrackOrder(),
                        )
                      : AccessDialogue(context),
                  child: Container(
                    height: Get.height * 0.13,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: customGrey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/Location.svg',
                          color: darkBlue,
                          height: 35,
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Track Orders',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'receive_orders.dart';
import 'write_review.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../../../controllers/profile_screen_controller.dart';
import 'top_header.dart';
import '../../../utils/colors.dart';
import 'package:get/get.dart';

class ReviewOrders extends StatefulWidget {
  const ReviewOrders({Key? key}) : super(key: key);

  @override
  _ReviewOrdersState createState() => _ReviewOrdersState();
}

class _ReviewOrdersState extends State<ReviewOrders> {
  final ProfileScreenController profileScreenController = Get.find();
  @override
  void initState() {
    profileScreenController.getOrders();
    super.initState();
  }

  void onCopyPressed(String orderId) async {
    await Clipboard.setData(
      ClipboardData(text: orderId),
    );
    await EasyLoading.showToast(
      'Id Copied',
      toastPosition: EasyLoadingToastPosition.top,
      maskType: EasyLoadingMaskType.clear,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only( left: 8, bottom: 6),
                  child: TopHeader(text: 'To Review'),
                ),
                profileScreenController.isLoading.value
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: Get.height / 2),
                          child: const CircularProgressIndicator(),
                        ),
                      )
                    : profileScreenController.Orders.value.orderList
                            .where((element) => element.status == 'Completed')
                            .where((item) => item.orderItems
                                .where((element) => element.isReviewed == false)
                                .isNotEmpty)
                            .isEmpty
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: Get.height / 4),
                              child: Column(
                                children: [
                                  Lottie.asset('assets/empty.json',
                                      height: Get.height * 0.3),
                                  const Text(
                                    'No Orders to review',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.black45),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: profileScreenController
                                .Orders.value.orderList
                                .where(
                                    (element) => element.status == 'Completed')
                                .where((item) => item.orderItems
                                    .where((element) =>
                                        element.isReviewed == false)
                                    .isNotEmpty)
                                .length,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 15),
                            itemBuilder: (context, index) {
                              var orders = profileScreenController
                                  .Orders.value.orderList
                                  .where((element) =>
                                      element.status == 'Completed')
                                  .toList();
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Placed On: ${DateFormat('dd-MM-yyyy').format(orders[index].dateOrdered.toLocal())}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: darkBlue,
                                              fontSize: 12,
                                            ),
                                          ),
                                          const Text(
                                            'Current Status: Delivered',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () =>
                                                onCopyPressed(orders[index].id),
                                            icon: const Icon(
                                              Icons.copy_rounded,
                                              size: 20,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () => Get.to(
                                              () => WriteReview(
                                                order: orders[index],
                                              ),
                                            ),
                                            child: const Text(
                                              'Review',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: customYellow,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: Get.width * 0.8,
                                    margin: const EdgeInsets.only(
                                        bottom: 16, top: 6),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: customGrey,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: ProductCard(
                                      products: orders[index]
                                          .orderItems
                                          .where((element) =>
                                              element.isReviewed == false)
                                          .toList(),
                                    ),
                                  ),
                                ],
                              );
                            }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

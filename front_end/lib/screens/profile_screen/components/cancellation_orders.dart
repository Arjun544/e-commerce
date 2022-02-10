import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../../../controllers/profile_screen_controller.dart';
import 'receive_orders.dart';
import 'top_header.dart';
import '../../../utils/colors.dart';
import 'package:get/get.dart';

class CancellationOrders extends StatefulWidget {
  const CancellationOrders({Key? key}) : super(key: key);

  @override
  _CancellationOrdersState createState() => _CancellationOrdersState();
}

class _CancellationOrdersState extends State<CancellationOrders> {
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
                  padding: EdgeInsets.only(top: 12.0, left: 8, bottom: 6),
                  child: TopHeader(text: 'Cancellation'),
                ),
                profileScreenController.isLoading.value
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: Get.height / 2),
                          child: const CircularProgressIndicator(),
                        ),
                      )
                    : profileScreenController.Orders.value.orderList
                            .where((element) => element.status == 'Cancelled')
                            .isEmpty
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: Get.height / 4),
                              child: Column(
                                children: [
                                  Lottie.asset('assets/empty.json',
                                      height: Get.height * 0.3),
                                  const Text(
                                    'No Orders',
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
                                    (element) => element.status == 'Cancelled')
                                .length,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 15),
                            itemBuilder: (context, index) {
                              var orders = profileScreenController
                                  .Orders.value.orderList
                                  .where((element) =>
                                      element.status == 'Cancelled')
                                  .toList();
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                            'Order No: ${orders[index].id}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: darkBlue,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            'Placed On: ${DateFormat('dd-MM-yyyy').format(orders[index].dateOrdered.toLocal())}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: darkBlue,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            'Current Status: ${orders[index].status}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            onCopyPressed(orders[index].id),
                                        icon: const Icon(
                                          Icons.copy_rounded,
                                          size: 30,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: Get.width,
                                    margin: const EdgeInsets.only(
                                        bottom: 16, top: 6),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: customGrey,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: ProductCard(
                                      products: orders[index].orderItems,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

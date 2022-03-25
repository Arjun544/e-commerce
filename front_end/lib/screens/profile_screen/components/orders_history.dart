import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../utils/colors.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'top_header.dart';
import '../../../controllers/profile_screen_controller.dart';

class OrdersHistory extends StatefulWidget {
  const OrdersHistory({Key? key}) : super(key: key);

  @override
  State<OrdersHistory> createState() => _OrdersHistoryState();
}

class _OrdersHistoryState extends State<OrdersHistory> {
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
                  padding: EdgeInsets.only(left: 8, bottom: 6),
                  child: TopHeader(text: 'Orders History'),
                ),
                profileScreenController.isLoading.value
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: Get.height / 2),
                          child: const CircularProgressIndicator(),
                        ),
                      )
                    : profileScreenController.Orders.value.orderList.isEmpty
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
                                      color: Colors.black45,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: profileScreenController
                                .Orders.value.orderList.length,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 15),
                            itemBuilder: (context, index) {
                              var orders = profileScreenController
                                  .Orders.value.orderList;
                              return Container(
                                height: Get.height * 0.3,
                                width: Get.width,
                                margin: const EdgeInsets.only(bottom: 10),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: customGrey,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          'Id : ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black45,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          orders[index].orderListId,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                        IconButton(
                                          onPressed: () =>
                                              onCopyPressed(orders[index].id),
                                          icon: const Icon(
                                            Icons.copy_rounded,
                                            size: 20,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              'Items : ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black45,
                                                  fontSize: 16),
                                            ),
                                            Text(
                                              'x${orders[index].orderItems.length.toString()}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 15),
                                          child: Row(
                                            children: [
                                              const Text(
                                                'Total : ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black45,
                                                    fontSize: 16),
                                              ),
                                              Text(
                                                orders[index]
                                                    .totalPrice
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Status : ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black45,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          orders[index].status,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 100,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          itemCount:
                                              orders[index].orderItems.length,
                                          itemBuilder: (context, indx) {
                                            return Container(
                                              width: Get.width * 0.7,
                                              margin: const EdgeInsets.only(
                                                  top: 10, right: 10),
                                              padding: const EdgeInsets.only(
                                                  right: 12, left: 8),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: orders[
                                                                  index]
                                                              .orderItems[indx]
                                                              .thumbnail,
                                                          fit: BoxFit.cover,
                                                          width:
                                                              Get.width * 0.15,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 15,
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width:
                                                                Get.width * 0.4,
                                                            child: Text(
                                                              orders[index]
                                                                  .orderItems[
                                                                      indx]
                                                                  .name,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14),
                                                            ),
                                                          ),
                                                          orders[index]
                                                                      .orderItems[
                                                                          indx]
                                                                      .discount >
                                                                  0
                                                              ? Text(
                                                                  '\$ ${orders[index].orderItems[indx].totalPrice.toString()}',
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          12),
                                                                )
                                                              : Text(
                                                                  '\$ ${orders[index].orderItems[indx].price.toString()}',
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    'x ${orders[index].orderItems[indx].quantity.toString()}',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                    ),
                                  ],
                                ),
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

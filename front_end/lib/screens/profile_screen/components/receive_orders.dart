import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../widgets/custom_button.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../../../models/order_model.dart';
import '../../../controllers/profile_screen_controller.dart';
import 'top_header.dart';
import '../../../utils/colors.dart';
import 'package:get/get.dart';

class ReceiveOrders extends StatefulWidget {
  const ReceiveOrders({Key? key}) : super(key: key);

  @override
  _ReceiveOrdersState createState() => _ReceiveOrdersState();
}

class _ReceiveOrdersState extends State<ReceiveOrders> {
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

  void onOrderCancel(String id) async {
    await EasyLoading.show(
        status: 'Cancelling',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.clear);
    await profileScreenController.updateOrderSttus(
      orderId: id,
      status: 'Cancelled',
    );
    await EasyLoading.dismiss();
    await EasyLoading.showToast(
      'Order cancelled',
      toastPosition: EasyLoadingToastPosition.top,
      maskType: EasyLoadingMaskType.clear,
    );
    profileScreenController.getOrders();
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
                  child: TopHeader(text: 'To Receive'),
                ),
                profileScreenController.isLoading.value
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: Get.height / 2),
                          child: const CircularProgressIndicator(),
                        ),
                      )
                    : profileScreenController.Orders.value.orderList
                            .where((element) =>
                                element.status != 'Completed' &&
                                element.status != 'Cancelled')
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
                                .where((element) =>
                                    element.status != 'Completed' &&
                                    element.status != 'Cancelled')
                                .length,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 15),
                            itemBuilder: (context, index) {
                              var orders = profileScreenController
                                  .Orders.value.orderList
                                  .where((element) =>
                                      element.status != 'Completed' &&
                                      element.status != 'Cancelled')
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
                                              color: darkBlue,
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
                                  Center(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 22),
                                      child: CustomButton(
                                        height: 50,
                                        width: Get.width * 0.4,
                                        text: 'Cancel',
                                        color: Colors.red,
                                        onPressed: () =>
                                            onOrderCancel(orders[index].id),
                                      ),
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

class ProductCard extends StatelessWidget {
  final List<OrderItem> products;

  const ProductCard({
    required this.products,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: products
          .map((product) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                            imageUrl: product.thumbnail,
                            fit: BoxFit.cover,
                            width: Get.width * 0.14,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                toBeginningOfSentenceCase(
                                        product.name) ??
                                    '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              Text(
                                '\$${product.totalPrice.toString()}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${toBeginningOfSentenceCase(product.subCategory)}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'x${product.quantity.toString()}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}

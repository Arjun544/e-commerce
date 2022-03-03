
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import '../../../controllers/profile_screen_controller.dart';
import '../../../models/trackOrder_model.dart';
import 'top_header.dart';
import '../../../services/orders_api.dart';
import '../../../utils/colors.dart';
import '../../../widgets/custom_button.dart';
import 'package:get/get.dart';

class TrackOrder extends StatefulWidget {
  const TrackOrder({Key? key}) : super(key: key);

  @override
  _TrackOrderState createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  final ProfileScreenController profileScreenController =
      Get.put(ProfileScreenController());
  bool isNavigatingFromNotification = false;

  TrackOrderModel? order;

  @override
  void initState() {
    if (profileScreenController.trackIdController.value.text.isNotEmpty) {
      isNavigatingFromNotification = true;
    }
    super.initState();
  }

  void onTrackOrder() async {
    if (profileScreenController.trackIdController.value.text.isNotEmpty) {
      await EasyLoading.show(
          status: 'Loading',
          dismissOnTap: false,
          maskType: EasyLoadingMaskType.clear);
      order = await ApiOrders().getOrderById(
          orderId: profileScreenController.trackIdController.value.text);
      await EasyLoading.dismiss();
      FocusScope.of(context).requestFocus(FocusNode());
      setState(() {});
    
    }
  }

  @override
  Widget build(BuildContext context) {
    Color statusColor = Colors.green;
    if (profileScreenController.trackIdController.value.text.isNotEmpty &&
        isNavigatingFromNotification == false) {
      switch (order!.orderList.status) {
        case 'Pending':
          statusColor = Colors.orange;
          break;
        case 'Conpleted':
          statusColor = Colors.green;
          break;
        case 'Confirmed':
          statusColor = Colors.purple;
          break;
        case 'Rejected':
          statusColor = Colors.red;
          break;
        case 'Processing':
          statusColor = Colors.grey;
          break;
        case 'Delivered':
          statusColor = Colors.green;
          break;
        case 'Cancelled':
          statusColor = Colors.red;
          break;
        default:
          statusColor = Colors.green;
      }
    }
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 12.0, left: 8, bottom: 6),
                child: TopHeader(text: 'Track Order'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 0, top: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50,
                      width: Get.width,
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      margin: const EdgeInsets.only(right: 18),
                      decoration: BoxDecoration(
                        color: customGrey,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.black12,
                            blurRadius: 2.0,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/Invoice.svg',
                            height: 25,
                            color: darkBlue.withOpacity(0.4),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: profileScreenController
                                  .trackIdController.value,
                              obscureText: false,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Order id',
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black45,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    CustomButton(
                      height: 50,
                      width: Get.width * 0.7,
                      text: 'Track',
                      color: customYellow,
                      onPressed: () => onTrackOrder(),
                    ),
                    order == null
                        ? Padding(
                            padding: EdgeInsets.only(top: Get.height / 3),
                            child: const Text(
                              'No order to track',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black45,
                                  fontSize: 18),
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(height: 30),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        order!.orderList.id,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
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
                                            'x${order!.orderList.orderItems.length.toString()}',
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
                                              order!.orderList.totalPrice
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
                                  SizedBox(
                                    height: 100,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            order!.orderList.orderItems.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            width: Get.width * 0.7,
                                            margin: const EdgeInsets.only(
                                                top: 10, right: 10),
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            decoration: BoxDecoration(
                                              color: customGrey,
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
                                                          BorderRadius.circular(
                                                              20),
                                                      child: CachedNetworkImage(
                                                        imageUrl: order!
                                                            .orderList
                                                            .orderItems[index]
                                                            .thumbnail,
                                                        fit: BoxFit.cover,
                                                        width: Get.width * 0.15,
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
                                                        Text(
                                                          order!
                                                              .orderList
                                                              .orderItems[index]
                                                              .name,
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16),
                                                        ),
                                                        order!
                                                                    .orderList
                                                                    .orderItems[
                                                                        index]
                                                                    .discount >
                                                                0
                                                            ? Text(
                                                                '\$ ${order!.orderList.orderItems[index].totalPrice.toString()}',
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        12),
                                                              )
                                                            : Text(
                                                                '\$ ${order!.orderList.orderItems[index].price.toString()}',
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
                                                  'x ${order!.orderList.orderItems[index].quantity.toString()}',
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
                              const SizedBox(height: 20),
                              const Text(
                                'Current Status:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                order!.orderList.status,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: statusColor,
                                    fontSize: 22),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 40),
                                  child: CustomButton(
                                    height: 50,
                                    width: Get.width * 0.4,
                                    text: 'Refresh',
                                    color: Colors.green,
                                    onPressed: () => onTrackOrder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front_end/controllers/profile_screen_controller.dart';
import '../../../utils/colors.dart';
import '../../../widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../models/order_model.dart';
import 'top_header.dart';

class WriteReview extends StatefulWidget {
  final Order order;
  const WriteReview({Key? key, required this.order}) : super(key: key);

  @override
  _WriteReviewState createState() => _WriteReviewState();
}

class _WriteReviewState extends State<WriteReview> {
  final ProfileScreenController profileScreenController = Get.find();
  final List<TextEditingController> _reviewController =
      <TextEditingController>[];
  double selectedRating = 0;

  Future<void> onAddReview(
      String productId, String review, double rating) async {
    await EasyLoading.show(status: 'Loading...', dismissOnTap: false);
    await profileScreenController.addReviews(
      productId: productId,
      review: review,
      rating: selectedRating,
    );
    selectedRating = 0;
    await EasyLoading.dismiss();
    Get.back();
    setState(() {
      profileScreenController.getOrders();
    });
  }

  Future<void> onSkipReview(
      int index, List<OrderItem> products, String orderId) async {
    await EasyLoading.show(status: 'Loading...', dismissOnTap: false);
    await profileScreenController.skipReview(
      id: orderId,
      productId: products[index].id,
    );
    products.remove(products[index]);
    await EasyLoading.dismiss();
    if (products.isEmpty) {
      Get.back();
    }

    setState(() {
      profileScreenController.getOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 12.0, left: 8, bottom: 6),
              child: TopHeader(text: 'Write Review'),
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: widget.order.orderItems
                      .where((element) => element.product.isReviewed == false)
                      .length,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemBuilder: (context, index) {
                    var orderItems = widget.order.orderItems
                        .where((element) => element.product.isReviewed == false)
                        .toList();
                    _reviewController.add(TextEditingController());
                    return Container(
                      width: Get.width * 0.8,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: customGrey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  imageUrl: orderItems[index].product.thumbnail,
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
                                              orderItems[index]
                                                  .product
                                                  .isReviewed
                                                  .toString()) ??
                                          '',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    Text(
                                      '\$${orderItems[index].product.totalPrice.toString()}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${toBeginningOfSentenceCase(orderItems[index].product.subCategory)}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Get.height * 0.04),
                          RatingBar.builder(
                            initialRating: 0,
                            updateOnDrag: true,
                            itemSize: 30,
                            minRating: 0,
                            maxRating: 5,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            itemBuilder: (context, _) => SvgPicture.asset(
                              'assets/images/Star.svg',
                              height: 20,
                              color: customYellow,
                            ),
                            onRatingUpdate: (rating) {
                              selectedRating = rating;
                            },
                          ),
                          SizedBox(height: Get.height * 0.04),
                          Center(
                            child: Container(
                              height: Get.height * 0.2,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  const BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 2.0,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                maxLines: 6,
                                controller: _reviewController[index],
                                textInputAction: TextInputAction.newline,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Write a review',
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black45,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: Get.height * 0.04),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomButton(
                                height: 50,
                                width: Get.width * 0.4,
                                text: 'Skip Review',
                                color: Colors.red,
                                onPressed: () => onSkipReview(
                                  index,
                                  orderItems,
                                  widget.order.id,
                                ),
                              ),
                              CustomButton(
                                height: 50,
                                width: Get.width * 0.4,
                                text: 'Add Review',
                                color: darkBlue,
                                onPressed: () => onAddReview(
                                  orderItems[index].product.id,
                                  _reviewController[index].text,
                                  selectedRating,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

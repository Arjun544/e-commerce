import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import '../../../models/product_Model.dart';
import '../../../utils/colors.dart';
import '../../../controllers/detail_screen_controller.dart';
import 'package:get/get.dart';

import 'reviews_section.dart';

class ProductDetails extends StatelessWidget {
  final Product product;
  final DetailScreenController controller;

  ProductDetails({required this.controller, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                product.discount > 0
                    ? Container(
                        height: 24,
                        width: 70,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '${product.discount}%',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'OFF',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            const SizedBox(height: 5),
            product.discount > 0
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\$${product.totalPrice.toString()}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '\$${product.price.toString()}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          decorationColor: Colors.red,
                          decorationThickness: 3,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  )
                : Text(
                    '\$ ${product.price.toString()}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                  ),
            const SizedBox(height: 10),
            Text(
              product.description,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 20),
            Obx(
              () => ListView.builder(
                key: Key('builder ${controller.selected.value.toString()}'),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: 3,
                itemBuilder: (context, index) {
                  // Calculating average of ratings

                  if (product.reviews.isNotEmpty) {
                    controller.averageRating = product.reviews
                            .map((m) => double.parse(m.rating.toString()))
                            .reduce((a, b) => a + b) /
                        product.reviews.length;
                  }
                  return Container(
                    margin: index == 0 || index == 1
                        ? const EdgeInsets.only(bottom: 20)
                        : const EdgeInsets.only(bottom: 0),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ExpansionTile(
                      key: Key(index.toString()),
                      expandedAlignment: Alignment.topLeft,
                      initiallyExpanded: controller.firstTap.value
                          ? index == controller.selected.value
                          : false,
                      title: Text(
                        index == 0
                            ? 'Full description'
                            : index == 1
                                ? 'Rating'
                                : 'Reviews ( ${product.totalReviews} )',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onExpansionChanged: (newState) {
                        controller.firstTap.value = true;
                        if (newState) {
                          const Duration(seconds: 2000);
                          controller.selected.value = index;
                        } else {
                          controller.selected.value = -1;
                        }
                      },
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: index == 0
                              ? Text(
                                  product.fullDescription,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : index == 1
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: product.reviews.isEmpty
                                          ? const Center(
                                              child: Text(
                                                'No Rating',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  controller.averageRating
                                                          .toString() +
                                                      ' / 5',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                RatingBar.builder(
                                                  initialRating:
                                                      controller.averageRating,
                                                  updateOnDrag: false,
                                                  ignoreGestures: true,
                                                  itemSize: 25,
                                                  minRating: 1,
                                                  maxRating: 5,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemPadding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 2.0),
                                                  itemBuilder: (context, _) =>
                                                      SvgPicture.asset(
                                                    'assets/images/Star.svg',
                                                    height: 20,
                                                    color: customYellow,
                                                  ),
                                                  onRatingUpdate: (rating) {
                                                    print(rating);
                                                  },
                                                ),
                                              ],
                                            ),
                                    )
                                  : ReviewsSection(
                                      reviews: product.reviews,
                                      totalReviews: product.totalReviews,
                                    ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

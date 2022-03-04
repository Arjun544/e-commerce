import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'AllArrivalsSection.dart';
import '../../../widgets/loaders/arrival_loader.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import '../../../controllers/cart_screen_controller.dart';
import '../../../controllers/home_screen_controller.dart';
import '../../../controllers/wishlist_controller.dart';
import '../../../models/product_Model.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../detail_screen/detail_screen.dart';

class ArrivalsSection extends StatelessWidget {
  final HomeScreenController homeScreenController;
  final CartScreenController cartScreenController;

  ArrivalsSection(
      {required this.homeScreenController, required this.cartScreenController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder(
            stream: homeScreenController.arrivalProductsStreamController.stream,
            builder: (context, AsyncSnapshot<ProductModel> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ArrivalsLoader();
              }

              return snapshot.data!.results.isEmpty
                  ? const SizedBox.shrink()
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15, left: 15, bottom: 10, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'New Arrivals',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  letterSpacing: 1,
                                ),
                              ),
                              InkWell(
                                onTap: () => Get.to(
                                  () => AllArrivalsSection(
                                    homeScreenController: homeScreenController,
                                    cartScreenController: cartScreenController,
                                  ),
                                ),
                                child: const Text(
                                  'View all',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: Get.height * 0.24,
                          alignment: Alignment.centerLeft,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.results.length,
                              padding: const EdgeInsets.only(left: 15),
                              itemBuilder: (context, index) {
                                Product product = snapshot.data!.results[index];
                                return index == snapshot.data!.results.length
                                    ? Container(
                                        width: 80,
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: const Text(
                                          'See All',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          Get.to(() => DetailScreen(
                                                product: product,
                                              ));
                                        },
                                        child: Container(
                                          width: Get.width * 0.55,
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: BuildItem(
                                            homeScreenController:
                                                homeScreenController,
                                            product: product,
                                          ),
                                        ),
                                      );
                              }),
                        ),
                      ],
                    );
            }),
      ],
    );
  }
}

class BuildItem extends StatelessWidget {
  final HomeScreenController homeScreenController;
  final Product product;

  BuildItem({required this.product, required this.homeScreenController});

  final WishListController wishListController = Get.find();

  @override
  Widget build(BuildContext context) {
    double averageRating = 0;
    if (product.reviews.isNotEmpty) {
      averageRating = product.reviews
              .map((m) => double.parse(m.rating.toString()))
              .reduce((a, b) => a + b) /
          product.reviews.length;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            Center(
              child: Container(
                height: 90,
                width: 180,
                margin: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: CachedNetworkImageProvider(
                      product.thumbnail,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                product.discount > 0
                    ? Container(
                        height: 24,
                        width: 70,
                        margin: const EdgeInsets.only(top: 8, left: 8),
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
                PreferenceBuilder<List<String>>(
                    preference: sharedPreferences
                        .getStringList('favListIds', defaultValue: []),
                    builder: (context, snapshot) {
                      wishListController.ids = snapshot;
                      return LikeButton(
                        mainAxisAlignment: MainAxisAlignment.end,
                        padding: const EdgeInsets.only(right: 15, top: 10),
                        size: 20,
                        isLiked: snapshot.contains(product.id) ? true : false,
                        circleColor: const CircleColor(
                          start: Colors.pink,
                          end: Colors.pink,
                        ),
                        bubblesColor: BubblesColor(
                          dotPrimaryColor: Colors.pink,
                          dotSecondaryColor: Colors.pink.withOpacity(0.5),
                        ),
                        likeBuilder: (bool isLiked) {
                          return isLiked
                              ? SvgPicture.asset(
                                  'assets/images/Heart.svg',
                                  color: Colors.pink,
                                )
                              : SvgPicture.asset(
                                  'assets/images/Heart-Outline.svg',
                                  color: Colors.black,
                                );
                        },
                        onTap: (isLiked) async {
                          snapshot.contains(product.id)
                              ? snapshot.remove(product.id)
                              : snapshot.add(product.id);
                          await sharedPreferences.setStringList(
                              'favListIds', snapshot);
                          return !isLiked;
                        },
                      );
                    }),
              ],
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                toBeginningOfSentenceCase(product.name) ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  product.discount > 0
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\$${product.totalPrice.toString()}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
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
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        ),
                ],
              ),
              Row(
                children: [
                  RatingBar.builder(
                    initialRating: averageRating,
                    updateOnDrag: false,
                    ignoreGestures: true,
                    itemSize: 10,
                    minRating: 1,
                    maxRating: 5,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                    itemBuilder: (context, _) => SvgPicture.asset(
                      'assets/images/Star.svg',
                      height: 20,
                      color: customYellow,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    averageRating.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

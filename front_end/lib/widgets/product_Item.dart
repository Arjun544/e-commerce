import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../controllers/home_screen_controller.dart';
import '../controllers/wishlist_controller.dart';
import '../models/product_Model.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class ProductItem extends StatelessWidget {
  final bool isBannerProduct;
  final Product product;
  final HomeScreenController homeScreenController;

  ProductItem(
      {required this.product,
      required this.homeScreenController,
      this.isBannerProduct = false});

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
                height: 155,
                width: 180,
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
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                  !isBannerProduct
                      ? PreferenceBuilder<List<String>>(
                          preference: sharedPreferences
                              .getStringList('wishlistIds', defaultValue: []),
                          builder: (context, snapshot) {
                            wishListController.wishlistIds = snapshot;
                            return LikeButton(
                              mainAxisAlignment: MainAxisAlignment.center,
                              size: 20,
                              isLiked:
                                  snapshot.contains(product.id) ? true : false,
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
                                    'wishlistIds', snapshot);
                                return !isLiked;
                              },
                            );
                          })
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          margin: const EdgeInsets.only(bottom: 0),
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
                overflow: TextOverflow.fade,
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
                          '\$${product.price.toString()}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
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

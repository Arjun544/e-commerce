import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
  final Product product;
  final HomeScreenController homeScreenController;

  ProductItem({required this.product, required this.homeScreenController});

  final WishListController wishListController = Get.find();

  @override
  Widget build(BuildContext context) {
    double averageRating = 0;
    if (product.reviews.isNotEmpty) {
      averageRating = product.reviews
              .map((m) => double.parse(m.number))
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
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                      product.image,
                    ),
                  ),
                ),
              ),
            ),
            PreferenceBuilder<List<String>>(
                preference: sharedPreferences
                    .getStringList('favListIds', defaultValue: []),
                builder: (context, snapshot) {
                  wishListController.ids = snapshot;
                  return LikeButton(
                    mainAxisAlignment: MainAxisAlignment.end,
                    padding: const EdgeInsets.only(top: 10, right: 5),
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$ ${product.price.toString()}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Star.svg',
                        height: 10,
                        color: customYellow,
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
            ],
          ),
        ),
      ],
    );
  }
}

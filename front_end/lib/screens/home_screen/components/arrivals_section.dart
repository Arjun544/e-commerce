import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../widgets/arrival_loader.dart';
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
    return StreamBuilder(
        stream: homeScreenController.arrivalProductsStreamController.stream,
        builder: (context, AsyncSnapshot<ProductModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ArrivalsLoader(
            );
          }

          return Container(
            height: Get.height * 0.24,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.products.length,
                padding: const EdgeInsets.only(left: 15),
                itemBuilder: (context, index) {
                  Product product = snapshot.data!.products[index];
                  return index == snapshot.data!.products.length
                      ? Container(
                          width: 80,
                          margin: const EdgeInsets.only(right: 10),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Text(
                            'See All',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
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
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: BuildItem(
                              homeScreenController: homeScreenController,
                              product: product,
                            ),
                          ),
                        );
                }),
          );
        });
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
                height: 110,
                width: 180,
                margin: const EdgeInsets.only(top: 5),
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
                              color: Colors.white,
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

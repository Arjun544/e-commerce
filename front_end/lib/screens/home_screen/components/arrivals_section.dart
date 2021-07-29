import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../controllers/wishlist_controller.dart';
import '../../detail_screen/detail_screen.dart';
import '../../../utils/constants.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import '../../../controllers/cart_screen_controller.dart';
import '../../../controllers/home_screen_controller.dart';
import '../../../models/product_Model.dart';
import '../../../utils/colors.dart';

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
            return const SizedBox();
          }

          return Container(
            height: Get.height * 0.22,
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
                            width: Get.width * 0.5,
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              color: customGrey,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            Center(
              child: CachedNetworkImage(
                imageUrl: product.image,
                fit: BoxFit.cover,
                width: Get.width * 0.25,
              ),
            ),
            PreferenceBuilder<List<String>>(
                preference: sharedPreferences
                    .getStringList('favListIds', defaultValue: []),
                builder: (context, snapshot) {
                  wishListController.ids = snapshot;
                  return LikeButton(
                    mainAxisAlignment: MainAxisAlignment.end,
                    padding: const EdgeInsets.only(right: 10, top: 5),
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
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 10),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    '\$ ${product.price.toString()}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
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

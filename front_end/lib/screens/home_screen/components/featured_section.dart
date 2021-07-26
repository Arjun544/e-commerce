import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import '../../../controllers/cart_screen_controller.dart';
import '../../../controllers/home_screen_controller.dart';
import '../../../controllers/wishlist_controller.dart';
import '../../../models/product_Model.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../detail_screen/detail_screen.dart';

class FeaturedSection extends StatefulWidget {
  final HomeScreenController homeScreenController;
  final CartScreenController cartScreenController;

  FeaturedSection(
      {required this.homeScreenController, required this.cartScreenController});

  @override
  _FeaturedSectionState createState() => _FeaturedSectionState();
}

class _FeaturedSectionState extends State<FeaturedSection> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            widget.homeScreenController.featuredProductsStreamController.stream,
        builder: (context, AsyncSnapshot<ProductModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }
          return StaggeredGridView.countBuilder(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              padding: const EdgeInsets.only(right: 10, left: 10, bottom: 70),
              itemCount: snapshot.data!.products.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                Product product = snapshot.data!.products[index];
                return GestureDetector(
                  onTap: () {
                    Get.off(() => DetailScreen(
                          product: product,
                        ));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: const BoxDecoration(
                      color: customGrey,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: BuildItem(
                      homeScreenController: widget.homeScreenController,
                      product: product,
                      index: index,
                    ),
                  ),
                );
              },
              staggeredTileBuilder: (index) {
                return StaggeredTile.count(1, index.isEven ? 1.4 : 1.5);
              });
        });
  }
}

class BuildItem extends StatelessWidget {
  final Product product;
  final int index;
  final HomeScreenController homeScreenController;

  BuildItem(
      {required this.index,
      required this.product,
      required this.homeScreenController});

  final WishListController wishListController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            CachedNetworkImage(
              imageUrl: product.image.toString(),
              fit: BoxFit.contain,
              width: Get.width * 0.5,
            ),
            PreferenceBuilder<List<String>>(
                preference: sharedPreferences
                    .getStringList('favListIds', defaultValue: []),
                builder: (context, snapshot) {
                  wishListController.ids = snapshot;
                  return LikeButton(
                    mainAxisAlignment: MainAxisAlignment.end,
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
                      isLiked
                          ? homeScreenController.favListIds.remove(product.id)
                          : homeScreenController.favListIds
                              .insert(0, product.id);
                      await sharedPreferences.setStringList(
                        'favListIds',
                        homeScreenController.favListIds,
                      );
                      return !isLiked;
                    },
                  );
                }),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
        ),
      ],
    );
  }
}

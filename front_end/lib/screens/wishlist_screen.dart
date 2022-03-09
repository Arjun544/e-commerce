import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../controllers/home_screen_controller.dart';
import '../controllers/wishlist_controller.dart';
import '../models/product_Model.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import 'detail_screen/detail_screen.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen();

  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final WishListController wishListController = Get.find();
  final HomeScreenController homeScreenController = Get.find();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (wishListController.wishlistIds.isNotEmpty) {
        wishListController.getWishlist();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(width: 40),
                  const Text(
                    'Wishlist',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  wishListController.wishlistIds.isEmpty
                      ? const SizedBox(
                          width: 15,
                        )
                      : GestureDetector(
                          onTap: () async {
                            await wishListController.clearWishlist();
                            wishListController.wishlistIds.clear();
                            await sharedPreferences.remove('wishlistIds');
                            setState(() {
                              wishListController.getWishlist();
                            });
                          },
                          child: const Text(
                            'Clear',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                ],
              ),
              wishListController.wishlistIds.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: Column(
                        children: [
                          Lottie.asset('assets/empty.json',
                              height: Get.height * 0.3),
                          const Text(
                            'Nothing in wishlist',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black45),
                          ),
                        ],
                      ),
                    )
                  : StreamBuilder(
                      stream: wishListController.wishlistController.stream,
                      builder: (context, AsyncSnapshot<ProductModel> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox();
                        }
                        log(snapshot.data!.results.toString());
                        return snapshot.data!.results.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(top: 80),
                                child: Column(
                                  children: [
                                    Lottie.asset('assets/empty.json',
                                        height: Get.height * 0.3),
                                    const Text(
                                      'Nothing in wishlist',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.black45),
                                    ),
                                  ],
                                ),
                              )
                            : StaggeredGridView.countBuilder(
                                shrinkWrap: true,
                                crossAxisCount: 2,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                                padding: const EdgeInsets.only(
                                    right: 15, left: 15, bottom: 20, top: 20),
                                itemCount: snapshot.data!.results.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  Product product =
                                      snapshot.data!.results[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Get.off(() => DetailScreen(
                                            product: product,
                                          ));
                                    },
                                    child: Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(7),
                                          decoration: const BoxDecoration(
                                            color: customGrey,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                          ),
                                          child: BuildItem(
                                            product: product,
                                            wishListController:
                                                wishListController,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            product.discount > 0
                                                ? Container(
                                                    height: 24,
                                                    width: 70,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: Colors.redAccent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text(
                                                          '${product.discount}%',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        const Text(
                                                          'OFF',
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : const SizedBox.shrink(),
                                            IconButton(
                                              onPressed: () async {
                                                wishListController.wishlistIds
                                                    .remove(product.id);
                                                wishListController.wishlistIds
                                                    .remove(product.id);
                                                await sharedPreferences
                                                    .setStringList(
                                                        'wishlistIds',
                                                        wishListController
                                                            .wishlistIds);
                                                setState(() {
                                                  wishListController
                                                      .getWishlist();
                                                });
                                              },
                                              icon: Icon(
                                                Icons.delete_rounded,
                                                size: 20,
                                                color: Colors.redAccent
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                staggeredTileBuilder: (index) {
                                  return StaggeredTile.count(
                                      1, index.isEven ? 1.5 : 1.6);
                                },
                              );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildItem extends StatelessWidget {
  final Product product;
  final WishListController wishListController;

  const BuildItem({required this.product, required this.wishListController});

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
        CachedNetworkImage(
          imageUrl: product.thumbnail.toString(),
          fit: BoxFit.contain,
          width: Get.width * 0.5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                toBeginningOfSentenceCase(product.name) ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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

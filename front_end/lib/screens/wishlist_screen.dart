import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/home_screen_controller.dart';
import '../controllers/wishlist_controller.dart';
import '../models/product_Model.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../widgets/customDialogue.dart';
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
      if (wishListController.ids.isNotEmpty) wishListController.getWishlist();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
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
                wishListController.ids.isEmpty
                    ? const SizedBox(
                        width: 15,
                      )
                    : GestureDetector(
                        onTap: getStorage.read('isLogin') == true
                            ? () async {
                                await wishListController.clearWishlist();
                                wishListController.ids.clear();
                                await sharedPreferences.remove('favListIds');
                                setState(() {
                                  wishListController.getWishlist();
                                });
                              }
                            : () {
                                AccessDialogue(context);
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
            wishListController.ids.isEmpty
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
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox();
                      }
                      return snapshot.data!.products.isEmpty
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
                                  right: 15, left: 15, bottom: 70, top: 20),
                              itemCount: snapshot.data!.products.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                Product product =
                                    snapshot.data!.products[index];
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
                                      IconButton(
                                        onPressed: getStorage.read('isLogin') ==
                                                true
                                            ? () async {
                                                log(homeScreenController
                                                    .favListIds
                                                    .toString());
                                                homeScreenController.favListIds
                                                    .remove(product.id);
                                                log(homeScreenController
                                                    .favListIds
                                                    .toString());
                                                wishListController.ids
                                                    .remove(product.id);
                                                await sharedPreferences
                                                    .setStringList(
                                                        'favListIds',
                                                        homeScreenController
                                                            .favListIds);
                                                setState(() {
                                                  wishListController
                                                      .getWishlist();
                                                });
                                              }
                                            : () {
                                                AccessDialogue(context);
                                              },
                                        icon: Icon(
                                          Icons.delete_rounded,
                                          size: 20,
                                          color:
                                              Colors.redAccent.withOpacity(0.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              staggeredTileBuilder: (index) {
                                return StaggeredTile.count(
                                    1, index.isEven ? 1.4 : 1.5);
                              },
                            );
                    },
                  ),
          ],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CachedNetworkImage(
          imageUrl: product.image.toString(),
          fit: BoxFit.contain,
          width: Get.width * 0.5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
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

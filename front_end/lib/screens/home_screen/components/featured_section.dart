import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../../controllers/cart_screen_controller.dart';
import '../../../controllers/home_screen_controller.dart';
import '../../../models/product_Model.dart';
import '../../../utils/colors.dart';
import '../../detail_screen/detail_screen.dart';

class FeaturedSection extends StatelessWidget {
  final HomeScreenController homeScreenController;
  final CartScreenController cartScreenController;

  FeaturedSection(
      {required this.homeScreenController, required this.cartScreenController});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: homeScreenController.featuredProductsStreamController.stream,
        builder: (context, AsyncSnapshot<ProductModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }
          return StaggeredGridView.countBuilder(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: snapshot.data!.products.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                Product product = snapshot.data!.products[index];
                return Stack(
                  clipBehavior: Clip.hardEdge,
                  alignment: Alignment.bottomRight,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.off(() => DetailScreen());
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          color: customGrey,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: BuildItem(
                          product: product,
                          index: index,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            log(cartScreenController.userId.value);
                            await cartScreenController.addToCart(
                                productId: product.id,
                                userId: cartScreenController.userId.value);
                          },
                          child: Container(
                            width: 40,
                            height: 30,
                            decoration: const BoxDecoration(
                              color: customYellow,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20),
                                topLeft: Radius.circular(15),
                              ),
                            ),
                            child: const Icon(
                              Icons.add_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
              staggeredTileBuilder: (index) {
                return StaggeredTile.count(1, index.isEven ? 1.2 : 1.3);
              });
        });
  }
}

class BuildItem extends StatelessWidget {
  final Product product;
  final int index;

  const BuildItem({required this.index, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: index.isEven ? Get.height * 0.195 : Get.height * 0.22,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: CachedNetworkImage(
            imageUrl: product.image.toString(),
            fit: BoxFit.cover,
            width: Get.width * 0.5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
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

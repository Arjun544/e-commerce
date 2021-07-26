import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                  return index == snapshot.data!.products.length - 1
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
                      : Container(
                          width: Get.width * 0.5,
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: darkBlue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: BuildItem(
                            product: product,
                          ),
                        );
                }),
          );
        });
  }
}

class BuildItem extends StatelessWidget {
  final Product product;

  const BuildItem({required this.product});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: Get.height * 0.13,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: CachedNetworkImage(
            imageUrl: product.image,
            fit: BoxFit.contain,
            width: Get.width * 0.5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
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

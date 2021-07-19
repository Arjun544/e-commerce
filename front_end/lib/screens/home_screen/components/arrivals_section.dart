import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:front_end/controllers/cart_screen_controller.dart';
import 'package:front_end/controllers/home_screen_controller.dart';
import 'package:front_end/models/product_Model.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';

class ArrivalsSection extends StatelessWidget {
  final HomeScreenController homeScreenController;
  final CartScreenController cartScreenController;

  ArrivalsSection(
      {required this.homeScreenController, required this.cartScreenController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.22,
      child: Obx(
        () => ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: homeScreenController.newArrivalProducts.length,
            padding: const EdgeInsets.only(left: 15),
            itemBuilder: (context, index) {
              return index == homeScreenController.newArrivalProducts.length - 1
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
                  : Stack(
                      clipBehavior: Clip.hardEdge,
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: Get.width * 0.5,
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: darkBlue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: BuildItem(
                            product:
                                homeScreenController.newArrivalProducts[index],
                          ),
                        ),
                        Positioned(
                          right: 10,
                          child: Obx(
                            () => Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: cartScreenController.cartItemIds
                                          .contains(homeScreenController
                                              .featuredProducts[index].id)
                                      ? () {
                                          cartScreenController.cartItemIds
                                              .remove(homeScreenController
                                                  .featuredProducts[index].id);
                                          cartScreenController.cartList.remove(
                                              homeScreenController
                                                  .featuredProducts[index]);

                                          cartScreenController.updateTotalPrice(
                                              homeScreenController
                                                  .featuredProducts[index]
                                                  .price);
                                        }
                                      : () {
                                          cartScreenController.cartItemIds.add(
                                              homeScreenController
                                                  .featuredProducts[index].id);
                                          cartScreenController.cartList.insert(
                                              0,
                                              homeScreenController
                                                  .featuredProducts[index]);
                                          cartScreenController
                                              .calculateTotalPrice(
                                                  homeScreenController
                                                      .featuredProducts[index]
                                                      .price);
                                        },
                                  child: Container(
                                    width: 40,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: cartScreenController.cartItemIds
                                              .contains(homeScreenController
                                                  .featuredProducts[index].id)
                                          ? Colors.redAccent
                                          : customYellow,
                                      borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(20),
                                        topLeft: Radius.circular(15),
                                      ),
                                    ),
                                    child: Icon(
                                      cartScreenController.cartItemIds.contains(
                                              homeScreenController
                                                  .featuredProducts[index].id)
                                          ? Icons.remove_rounded
                                          : Icons.add_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
            }),
      ),
    );
  }
}

class BuildItem extends StatelessWidget {
  final ProductModel product;

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
            // image: DecorationImage(
            //   image: NetworkImage(product.image),
            // ),
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

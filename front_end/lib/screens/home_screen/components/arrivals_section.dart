import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../controllers/cart_screen_controller.dart';
import '../../../controllers/home_screen_controller.dart';
import '../../../models/product_Model.dart';
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
      child: StreamBuilder(
          stream: homeScreenController.arrivalProductsStreamController.stream,
          builder: (context, AsyncSnapshot<ProductModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox();
            }
           if(snapshot.hasData){
             return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data(),
                  padding: const EdgeInsets.only(left: 15),
                  itemBuilder: (context, index) {
                    return index ==
                            homeScreenController.newArrivalProducts.length - 1
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
                                  product: homeScreenController
                                      .newArrivalProducts[index],
                                ),
                              ),
                              Positioned(
                                right: 10,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
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
                              ),
                            ],
                          );
                  });
           } 
          }),
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

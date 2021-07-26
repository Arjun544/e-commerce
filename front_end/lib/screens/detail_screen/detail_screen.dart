import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front_end/controllers/cart_screen_controller.dart';
import 'package:front_end/models/product_Model.dart';
import 'package:front_end/utils/constants.dart';
import 'package:get/get.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import '../../controllers/detail_screen_controller.dart';
import '../../utils/colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/draggable_home.dart';
import 'components/product_details.dart';
import 'components/product_images.dart';
import 'components/top_header.dart';

class DetailScreen extends StatelessWidget {
  final Product product;

  DetailScreen({required this.product});

  final DetailScreenController detailScreenController = Get.find();
  final CartScreenController cartScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      curvedBodyRadius: 0,
      headerExpandedHeight: 0.5,
      title: TopHeader(
        productId: product.id,
      ),
      headerWidget: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 45, right: 12, left: 10),
          child: Column(
            children: [
              TopHeader(
                productId: product.id,
              ),
              const SizedBox(height: 10),
              ProductImages(
                controller: detailScreenController,
                images: product.images,
              ),
            ],
          ),
        ),
      ),
      body: [
        ProductDetails(
          controller: detailScreenController,
          product: product,
        ),
      ],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: customYellow,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Badge(
                badgeContent: PreferenceBuilder<List<String>>(
                    preference: sharedPreferences
                        .getStringList('cartProductsIds', defaultValue: []),
                    builder: (context, snapshot) {
                      return Text(
                        snapshot.length.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: 12),
                      );
                    }),
                badgeColor: Colors.white,
                position: BadgePosition.topEnd(top: 5, end: 5),
                child: SvgPicture.asset(
                  'assets/images/Bag.svg',
                  height: 30,
                  color: Colors.white,
                ),
              ),
            ),
            CustomButton(
              height: 50,
              width: Get.width * 0.5,
              text: 'Add to Cart',
              color: darkBlue,
              onPressed: () async {
                await cartScreenController.addToCart(productId: product.id);
                cartScreenController.cartProductsIds.add(product.id);
                await sharedPreferences.setStringList(
                  'cartProductsIds',
                  cartScreenController.cartProductsIds,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

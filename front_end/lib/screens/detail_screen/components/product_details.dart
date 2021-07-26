import 'package:flutter/material.dart';
import 'package:front_end/models/product_Model.dart';
import '../../../controllers/detail_screen_controller.dart';
import '../../../widgets/customTIle.dart';
import 'package:get/get.dart';

class ProductDetails extends StatelessWidget {
  final Product product;
  final DetailScreenController controller;

  ProductDetails({required this.controller, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 5),
              Text(
                '\$ ${product.price.toString()}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                product.description,
                maxLines: 2,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() => CustomTile(
                    title: 'Full Description',
                    isTapped: controller.isTileTappedOne.value,
                    isExpanded: controller.isTileExpandedOne.value,
                    updateTileStatus: controller.updateTileStatusOne,
                    desc: product.fullDescription,
                  )),
              const SizedBox(
                height: 20,
              ),
              Obx(() => CustomTile(
                    title: 'Reviews',
                    isTapped: controller.isTileTappedTwo.value,
                    isExpanded: controller.isTileExpandedTwo.value,
                    updateTileStatus: controller.updateTileStatusTwo,
                    desc: product.reviews[0]['review'],
                  )),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Similar Products',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        // const FeaturedSection(),
      ],
    );
  }
}

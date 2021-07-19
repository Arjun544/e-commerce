import 'package:flutter/material.dart';
import '../../../controllers/detail_screen_controller.dart';
import '../../../widgets/customTIle.dart';
import 'package:get/get.dart';

class ProductDetails extends StatelessWidget {
  final DetailScreenController controller;

  ProductDetails({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Name',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 5),
              const Text(
                r'$60',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Descrption about product is here',
                maxLines: 2,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() => CustomTile(
                    title: 'Full decription',
                    isTapped: controller.isTileTappedOne.value,
                    isExpanded: controller.isTileExpandedOne.value,
                    updateTileStatus: controller.updateTileStatusOne,
                    desc:
                        'Eu consequat amet eiusmod pariatur veniam. In ex sint officia esse mollit culpa velit. In consectetur Lorem proident et ullamco.',
                  )),
              const SizedBox(
                height: 20,
              ),
              Obx(() => CustomTile(
                    title: 'Reviews',
                    isTapped: controller.isTileTappedTwo.value,
                    isExpanded: controller.isTileExpandedTwo.value,
                    updateTileStatus: controller.updateTileStatusTwo,
                    desc:
                        'Eu consequat amet eiusmod pariatur veniam. In ex sint officia esse mollit culpa velit. In consectetur Lorem proident et ullamco.',
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

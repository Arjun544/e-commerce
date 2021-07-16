import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:front_end/controllers/home_screen_controller.dart';
import 'package:front_end/models/featuredProduct_Model.dart';
import '../../detail_screen/detail_screen.dart';
import '../../../utils/colors.dart';
import 'package:get/get.dart';

class FeaturedSection extends StatelessWidget {
  final HomeScreenController homeScreenController;

  const FeaturedSection({required this.homeScreenController});

  @override
  Widget build(BuildContext context) {
    
    return Obx(
      () => StaggeredGridView.countBuilder(
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          itemCount: homeScreenController.featuredProducts.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
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
                      products: homeScreenController.featuredProducts,
                      index: index,
                    ),
                  ),
                ),
                Container(
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
              ],
            );
          },
          staggeredTileBuilder: (index) {
            
            return StaggeredTile.count(1, index.isEven ? 1.2 : 1.3);
          }),
    );
  }
}

class BuildItem extends StatelessWidget {
  final List<FeaturedProductModel> products;
  final int index;

  const BuildItem({required this.index, required this.products});

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
            image: DecorationImage(
              image:
                  NetworkImage(products[index].image),
            ),
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
                    products[index].name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    '\$ ${products[index].price.toString()}',
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

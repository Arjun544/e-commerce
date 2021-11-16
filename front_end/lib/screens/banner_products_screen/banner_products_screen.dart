import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import '../../widgets/draggable_scaffold.dart';
import '../../controllers/root_screen_controller.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/home_screen_controller.dart';
import '../../models/product_Model.dart';
import '../../utils/colors.dart';
import '../../widgets/product_Item.dart';
import '../detail_screen/detail_screen.dart';

class BannerProductsScreen extends StatelessWidget {
  final List<Product> products;
  final String banner;
  final bool isDeal;

  BannerProductsScreen({
    required this.products,
    this.isDeal = false,
    this.banner = '',
  });
  final HomeScreenController homeScreenController = Get.find();
  final RootScreenController rootScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return DraggableScaffold(
      curvedBodyRadius: 0,
      headerExpandedHeight: 0.3,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: SvgPicture.asset(
              'assets/images/Arrow - Left.svg',
              height: 25,
              color: darkBlue.withOpacity(0.7),
            ),
          ),
          const Text(
            'On Sale',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(width: 20),
        ],
      ),
      headerWidget: Padding(
        padding: const EdgeInsets.only(top: 45, right: 12, left: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: SvgPicture.asset(
                    'assets/images/Arrow - Left.svg',
                    height: 25,
                    color: darkBlue.withOpacity(0.7),
                  ),
                ),
                const Text(
                  'On Sale',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(width: 20),
              ],
            ),
            !isDeal
                ? Container(
                    height: Get.height * 0.18,
                    width: Get.width,
                    margin: const EdgeInsets.only(top: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: banner,
                        fit: BoxFit.fill,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
      body: [
        products.isEmpty
            ? Column(
                children: [
                  Lottie.asset('assets/empty.json', height: Get.height * 0.3),
                  const Text(
                    'No products',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black45),
                  ),
                ],
              )
            : StaggeredGridView.countBuilder(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                padding: const EdgeInsets.only(right: 12, left: 12, bottom: 20),
                itemCount: products.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  Product product = products[index];

                  return GestureDetector(
                    onTap: () {
                      Get.to(
                        () => DetailScreen(
                          isBannerProduct: true,
                          product: product,
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: ProductItem(
                        isBannerProduct: true,
                        homeScreenController: homeScreenController,
                        product: product,
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (index) {
                  return StaggeredTile.count(1, index.isEven ? 1.5 : 1.6);
                }),
      ],
    );
  }
}

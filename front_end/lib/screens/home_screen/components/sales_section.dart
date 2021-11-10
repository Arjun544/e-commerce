import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../banner_products_screen/banner_products_screen.dart';
import '../../../widgets/loaders/banner_loader.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../controllers/home_screen_controller.dart';
// ignore: library_prefixes
import '../../../models/banner_model.dart' as bannerModel;

class SalesSection extends StatelessWidget {
  final HomeScreenController controller;

  const SalesSection({Key? key, required this.controller});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const BannerLoader()
          : controller.banners.value.banners.isNotEmpty
              ? Flexible(
                  child: PageView.builder(
                    physics: controller.banners.value.banners.length > 1
                        ? const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics())
                        : const NeverScrollableScrollPhysics(),
                    itemCount: controller.banners.value.banners.length,
                    scrollDirection: Axis.horizontal,
                    controller: controller.salesPageController,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (controller.banners.value.banners[index].type ==
                              'Sale') {
                            Get.to(
                              () => BannerProductsScreen(
                                banner: controller
                                    .banners.value.banners[index].image,
                                products: controller
                                    .banners.value.banners[index].products,
                              ),
                            );
                          }
                        },
                        child: Stack(
                          children: [
                            SalesItem(
                              banner: controller.banners.value.banners[index],
                            ),
                            Positioned.fill(
                              bottom: 30,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: SmoothPageIndicator(
                                  controller: controller.salesPageController,
                                  count:
                                      controller.banners.value.banners.length,
                                  effect: const ExpandingDotsEffect(
                                    activeDotColor: Colors.white,
                                    dotColor: Colors.black54,
                                    expansionFactor: 2,
                                    dotHeight: 5,
                                    dotWidth: 8,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              : const SizedBox.shrink(),
    );
  }
}

class SalesItem extends StatelessWidget {
  final bannerModel.Banner banner;
  const SalesItem({
    Key? key,
    required this.banner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: Get.height * 0.18,
          width: Get.width,
          margin: const EdgeInsets.only(top: 15),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: banner.image,
              fit: BoxFit.fill,
            ),
          ),
        ),
        banner.type == 'Sale'
            ? Positioned(
                top: 30,
                child: Container(
                  height: 24,
                  width: 70,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(7),
                      bottomRight: Radius.circular(7),
                    ),
                  ),
                  child: const Text(
                    'Hot Sale',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}

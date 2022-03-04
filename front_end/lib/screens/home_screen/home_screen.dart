import 'package:flutter/material.dart';
import '../banner_products_screen/banner_products_screen.dart';
import 'components/deal_section.dart';
import '../../widgets/loaders/banner_loader.dart';
import 'package:get/get.dart';

import '../../controllers/cart_screen_controller.dart';
import '../../controllers/home_screen_controller.dart';
import '../../controllers/register_screen_controller.dart';
import '../../controllers/root_screen_controller.dart';
import '../../widgets/draggable_home.dart';
import 'components/arrivals_section.dart';
import 'components/categories_section.dart';
import 'components/featured_section.dart';
import 'components/sales_section.dart';
import 'components/top_bar.dart';

class HomeScreen extends StatelessWidget {
  final HomeScreenController homeScreenController = Get.find();
  final CartScreenController cartScreenController = Get.find();
  final RootScreenController rootScreenController = Get.find();
  final RegisterScreenController registerScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      backgroundColor: Colors.white,
      controller: rootScreenController,
      curvedBodyRadius: 0,
      headerExpandedHeight: 0.3,
      title: TopBar(
        homeScreenController: homeScreenController,
        rootScreenController: rootScreenController,
      ),
      headerWidget: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 45, right: 12, left: 10),
          child: Column(
            children: [
              TopBar(
                homeScreenController: homeScreenController,
                rootScreenController: rootScreenController,
              ),
              SalesSection(
                controller: homeScreenController,
              ),
            ],
          ),
        ),
      ),
      body: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CategoriesSection(),
            Obx(
              () => SizedBox(
                child: homeScreenController.deals.value.deals.isEmpty
                    ? const SizedBox.shrink()
                    :
                    // DateTime.now().isAfter(
                    //         homeScreenController.deals.value.deals[0].endDate)
                    //     ? const SizedBox.shrink()
                    //     :
                    Padding(
                        padding:
                            const EdgeInsets.only(right: 15, left: 15, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Flash Deal',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    letterSpacing: 1,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Get.to(
                                    () => BannerProductsScreen(
                                      products: homeScreenController
                                          .deals.value.deals[0].products,
                                    ),
                                  ),
                                  child: const Text(
                                    'View all',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            homeScreenController.isDealLoading.value
                                ? const Center(
                                    child: BannerLoader(
                                    height: 60,
                                  ))
                                : DealSection(
                                    controller: homeScreenController,
                                  ),
                          ],
                        ),
                      ),
              ),
            ),
            ArrivalsSection(
              homeScreenController: homeScreenController,
              cartScreenController: cartScreenController,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15, left: 15, bottom: 10),
              child: Text(
                'Featured',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  letterSpacing: 1,
                ),
              ),
            ),
            FeaturedSection(
              homeScreenController: homeScreenController,
              cartScreenController: cartScreenController,
            ),
          ],
        ),
      ],
    );
  }
}

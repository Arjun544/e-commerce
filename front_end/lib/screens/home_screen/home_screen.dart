import 'package:flutter/material.dart';
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
            ArrivalsSection(
              homeScreenController: homeScreenController,
              cartScreenController: cartScreenController,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15, left: 15, bottom: 10),
              child: Text(
                'Featured',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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

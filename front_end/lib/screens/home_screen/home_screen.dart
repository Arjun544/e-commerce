import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_screen_controller.dart';
import '../../widgets/draggable_home.dart';
import 'components/arrivals_section.dart';
import 'components/categories_section.dart';
import 'components/featured_section.dart';
import 'components/sales_section.dart';
import 'components/top_bar.dart';

class HomeScreen extends StatelessWidget {
  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      curvedBodyRadius: 0,
      headerExpandedHeight: 0.3,
      title: const TopBar(),
      headerWidget: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 45, right: 12, left: 10),
          child: Column(
            children: [
              const TopBar(),
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
            const CategoriesSection(),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 15, bottom: 10),
              child: Obx(() => Row(
                    children: [
                      const Text(
                        'New Arrivals',
                        style:  TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(width: 10,),
                      Text(
                        homeScreenController.currentUser?.value.data?.username?? 'Not logged in',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  )),
            ),
            const ArrivalsSection(),
            const Padding(
              padding: EdgeInsets.only(top: 15, left: 15, bottom: 10),
              child: Text(
                'Featured',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            const FeaturedSection(),
          ],
        ),
      ],
    );
  }
}

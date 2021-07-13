import 'package:badges/badges.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front_end/controllers/home_screen_controller.dart';
import 'package:front_end/utils/colors.dart';
import 'package:get/get.dart';

import 'components/custom_bar.dart';
import 'components/sales_section.dart';
import 'components/top_bar.dart';

class HomeScreen extends StatelessWidget {
  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DraggableHome(
        curvedBodyRadius: 0,
        title: TopBar(),
        headerWidget: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 20, right: 12, left: 12),
            child: Column(
              children: [
                TopBar(),
                SalesSection(),
              ],
            ),
          ),
        ),
        body: [],
        floatingActionButton: FloatingActionButton(
          backgroundColor: darkBlue,
          onPressed: () {},
          child: Badge(
            badgeContent: const Text(
              '2',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  fontSize: 12),
            ),
            badgeColor: Colors.white,
            child: SvgPicture.asset(
              'assets/images/Bag.svg',
              height: 25,
              color: Colors.white,
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 15, right: 60, left: 60),
          child: CustomBar(
            controller: homeScreenController,
          ),
        ),
      ),
    );
  }
}

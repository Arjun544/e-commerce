import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'cart_screen.dart';
import '../controllers/root_screen_controller.dart';
import 'favourite_screen.dart';
import 'home_screen/home_screen.dart';
import 'notifications_screen.dart';
import '../utils/colors.dart';
import 'package:get/get.dart';

import 'home_screen/components/custom_bar.dart';

class RootScreen extends StatelessWidget {
  final RootScreenController rootScreenController =
      Get.put(RootScreenController());

  final List<Widget> children = [
    HomeScreen(),
    const FavouriteScreen(),
    const NotificationsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        extendBody: true,
        body: children[rootScreenController.currentIndex.value],
        floatingActionButton: FloatingActionButton(
          backgroundColor: darkBlue,
          onPressed: () {
            Get.to(
              () => const CartScreen(),
            );
          },
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
            controller: rootScreenController,
          ),
        ),
      ),
    );
  }
}
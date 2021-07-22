import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front_end/controllers/register_screen_controller.dart';
import 'package:front_end/screens/register_screen/register_screen.dart';
import 'package:front_end/utils/constants.dart';
import '../controllers/cart_screen_controller.dart';
import 'package:get/get.dart';

import '../controllers/root_screen_controller.dart';
import '../utils/colors.dart';
import 'cart_screen.dart';
import 'favourite_screen.dart';
import 'home_screen/components/custom_bar.dart';
import 'home_screen/home_screen.dart';
import 'notifications_screen.dart';

class RootScreen extends StatelessWidget {
  final RootScreenController rootScreenController =
      Get.find();
  final CartScreenController cartScreenController =
      Get.find();
  final RegisterScreenController registerScreenController =
      Get.find();

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
            log(getStorage.read('isLogin').toString());
            getStorage.read('isLogin') == false
                ? Get.to(
                    () => RegisterScreen(),
                  )
                : Get.to(
                    () => CartScreen(),
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

import 'package:badges/badges.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../controllers/root_screen_controller.dart';
import '../../../utils/colors.dart';
import 'package:get/get.dart';

class CustomBar extends StatelessWidget {
  final RootScreenController controller;

  const CustomBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomNavigationBar(
        iconSize: 30.0,
        backgroundColor: darkBlue,
        isFloating: true,
        elevation: 2,
        strokeColor: Colors.white,
        borderRadius: const Radius.circular(20.0),
        items: [
          CustomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/Home.svg',
              color: controller.currentIndex.value == 0
                  ? Colors.white
                  : Colors.white54,
            ),
          ),
          CustomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/Heart.svg',
              color: controller.currentIndex.value == 1
                  ? Colors.white
                  : Colors.white54,
            ),
          ),
          CustomNavigationBarItem(
            icon: Badge(
              badgeColor: Colors.red,
              position: BadgePosition.topEnd(end: 0, top: 0),
              child: SvgPicture.asset(
                'assets/images/Notification.svg',
                color: controller.currentIndex.value == 2
                    ? Colors.white
                    : Colors.white54,
              ),
            ),
          ),
        ],
        currentIndex: controller.currentIndex.value,
        onTap: (index) {
          controller.updateIndex(index);
        },
      ),
    );
  }
}

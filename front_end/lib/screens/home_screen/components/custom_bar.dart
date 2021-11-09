import 'package:badges/badges.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../controllers/root_screen_controller.dart';
import '../../../utils/colors.dart';

class CustomBar extends StatelessWidget {
  final RootScreenController controller;

  const CustomBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: controller.isBottomBarVisible.value
            ? GetPlatform.isIOS
                ? Get.height * 0.12
                : Get.height * 0.08
            : 0.0,
        margin: controller.isBottomBarVisible.value
            ? const EdgeInsets.only(bottom: 15, right: 60, left: 60)
            : const EdgeInsets.symmetric(horizontal: 60),
        child: SingleChildScrollView(
          child: CustomNavigationBar(
            iconSize: controller.isBottomBarVisible.value ? 30.0 : 0.0,
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
                icon: !controller.isBottomBarVisible.value
                    ? SvgPicture.asset(
                        'assets/images/Notification.svg',
                        color: controller.currentIndex.value == 2
                            ? Colors.white
                            : Colors.white54,
                      )
                    : Badge(
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
        ),
      ),
    );
  }
}

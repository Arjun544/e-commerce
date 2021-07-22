import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:front_end/controllers/register_screen_controller.dart';
import 'package:front_end/controllers/root_screen_controller.dart';
import 'package:front_end/models/userModel.dart';
import 'package:front_end/utils/constants.dart';
import '../../controllers/cart_screen_controller.dart';
import 'package:get/get.dart';

import '../../controllers/home_screen_controller.dart';
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
              child: Row(
                children: [
                  const Text(
                    'New Arrivals',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  getStorage.read('isLogin') == true
                      ? StreamBuilder(
                          stream:
                              rootScreenController.currentUserController.stream,
                          builder:
                              (context, AsyncSnapshot<UserModel> snapshot) {
                            log(snapshot.data!.data.toString());
                            cartScreenController.userId.value =
                                snapshot.data!.data!.id;
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const SizedBox();
                            }
                            return Text(
                              snapshot.data!.data!.username,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            );
                          })
                      : const SizedBox.shrink(),
                  Text(
                    getStorage.read('isLogin') == true
                        ? ' Logout'
                        : ' Not logged in',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
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

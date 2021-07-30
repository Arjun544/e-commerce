import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/customDialogue.dart';
import '../controllers/register_screen_controller.dart';
import '../utils/constants.dart';
import '../controllers/cart_screen_controller.dart';
import 'package:get/get.dart';

import '../controllers/root_screen_controller.dart';
import '../utils/colors.dart';
import 'cart_screen/cart_screen.dart';
import 'wishlist_screen.dart';
import 'home_screen/components/custom_bar.dart';
import 'home_screen/home_screen.dart';
import 'notifications_screen.dart';

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final RootScreenController rootScreenController = Get.find();

  final CartScreenController cartScreenController = Get.find();

  final RegisterScreenController registerScreenController = Get.find();

  final List<Widget> children = [
    HomeScreen(),
    const WishlistScreen(),
    const NotificationsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (getStorage.read('isLogin') == true) {
        getCurrentUser();
        cartScreenController.currentUserId.value =
            rootScreenController.currentUser.data!.id;
        log(rootScreenController.currentUser.data!.username);
      }
    });
  }

  void getCurrentUser() async {
    rootScreenController.currentUser =
        (await rootScreenController.getCurrentUser())!;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        extendBody: true,
        body: children[rootScreenController.currentIndex.value],
        floatingActionButton: FloatingActionButton(
          backgroundColor: darkBlue,
          onPressed: () async {
            getStorage.read('isLogin') == true
                ? Get.to(
                    () => CartScreen(),
                  )
                : customDialogue(context);
          },
          child: Badge(
            badgeContent: getStorage.read('isLogin') == true
                ? StreamBuilder<DocumentSnapshot>(
                    stream: firebaseFirestore
                        .collection('carts')
                        .doc(cartScreenController.currentUserId.value)
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox.shrink();
                      }
                      return Text(
                        snapshot.data!['productIds']?.length.toString() ?? '0',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: 12),
                      );
                    })
                : const Text(
                    '0',
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

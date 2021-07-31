import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controllers/home_screen_controller.dart';
import '../../controllers/profile_screen_controller.dart';
import '../../controllers/root_screen_controller.dart';
import '../../models/userModel.dart';
import '../../utils/colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/draggable_home.dart';
import 'components/edit_profile.dart';
import 'components/profile_tile.dart';
import 'components/top_header.dart';
import 'components/user_image.dart';

class ProfileScreen extends StatelessWidget {
  final RootScreenController rootScreenController = Get.find();
  final ProfileScreenController profileScreenController = Get.find();
  final HomeScreenController homeScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel>(
        stream: rootScreenController.currentUserStreamController.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          } else if (snapshot.data == null) {}
          UserModel? currentUser = snapshot.data;
          return DraggableHome(
            curvedBodyRadius: 0,
            headerExpandedHeight: 0.31,
            title: const TopHeader(
              text: 'Profile',
            ),
            headerWidget: Container(
              child: Column(
                children: [
                  const TopHeader(text: 'Profile'),
                  const SizedBox(height: 30),
                  UserImage(
                    currentUser: currentUser,
                    controller: profileScreenController,
                  ),
                ],
              ),
            ),
            body: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Settings',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ProfileTile(
                      text: 'Edit Profile',
                      icon: 'assets/images/Profile.svg',
                      iconColor: Colors.green[300],
                      onPressed: () {
                        Get.to(
                          () => EditProfile(
                            currentUser: currentUser,
                            profileScreenController: profileScreenController,
                          ),
                        );
                      },
                    ),
                    ProfileTile(
                      text: 'Password Reset',
                      icon: 'assets/images/Lock.svg',
                      iconColor: Colors.grey,
                      onPressed: () {},
                    ),
                    ProfileTile(
                      text: 'Shipping Address',
                      icon: 'assets/images/Location.svg',
                      iconColor: Colors.orange[300],
                      onPressed: () {},
                    ),
                    ProfileTile(
                      text: 'Payment Method',
                      icon: 'assets/images/Scan.svg',
                      iconColor: Colors.teal[300],
                      onPressed: () {},
                    ),
                    ProfileTile(
                      text: 'Order History',
                      icon: 'assets/images/Invoice.svg',
                      iconColor: Colors.purple[300],
                      onPressed: () {},
                    ),
                    ProfileTile(
                      text: 'Rate Us',
                      icon: 'assets/images/Invoice.svg',
                      iconColor: Colors.purple[300],
                      onPressed: () {},
                    ),
                    ProfileTile(
                      text: 'Logout',
                      icon: 'assets/images/Logout.svg',
                      iconColor: Colors.red[400],
                      onPressed: () {},
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: Get.height * 0.15,
                      decoration: BoxDecoration(
                        color: Colors.green[400]!.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/images/Headphone.svg',
                                height: 30,
                                color: darkBlue.withOpacity(0.7),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Text(
                                'How can we help you?',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ],
                          ),
                          CustomButton(
                            height: 35,
                            width: Get.width * 0.3,
                            text: 'Send email',
                            color: Colors.green[300],
                            onPressed: () async {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}

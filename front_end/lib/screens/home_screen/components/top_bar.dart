import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../controllers/home_screen_controller.dart';
import '../../../controllers/root_screen_controller.dart';
import '../../../models/userModel.dart';
import '../../profile_screen/profile_screen.dart';
import '../../../utils/constants.dart';
import 'package:get/get.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'search_delegate.dart';
import '../../../utils/colors.dart';

class TopBar extends StatelessWidget {
  final RootScreenController rootScreenController;
  final HomeScreenController homeScreenController;
  const TopBar(
      {required this.rootScreenController, required this.homeScreenController});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          'assets/images/Category.svg',
          height: 25,
          color: darkBlue,
        ),
        Row(
          children: [
            InkWell(
              onTap: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                );
              },
              child: SvgPicture.asset(
                'assets/images/Search.svg',
                height: 25,
                color: Colors.grey.withOpacity(0.5),
              ),
            ),
            const SizedBox(width: 20),
            getStorage.read('isLogin') == true
                ? StreamBuilder<UserModel>(
                    stream:
                        rootScreenController.currentUserStreamController.stream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircleAvatar(radius: 20);
                      } else if (snapshot.data == null) {}
                      UserModel? currentUser = snapshot.data;
                      return InkWell(
                        onTap: () {
                          Get.to(
                            () => ProfileScreen(),
                          );
                        },
                        radius: 10,
                        child: currentUser!.data!.profile != ''
                            ? Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        currentUser.data!.profile),
                                  ),
                                ),
                              )
                            : PreferenceBuilder<String>(
                                preference: sharedPreferences.getString(
                                    'user profile',
                                    defaultValue:
                                        'assets/avatars/avatar 9.png'),
                                builder: (context, snapshot) {
                                  return CircleAvatar(
                                    radius: 20,
                                    backgroundImage: AssetImage(
                                      snapshot,
                                    ),
                                  );
                                }),
                      );
                    })
                : barActions(),
          ],
        ),
      ],
    );
  }
}

Widget barActions() {
  return InkWell(
      onTap: () {
        Get.to(
          () => ProfileScreen(),
        );
      },
      radius: 10,
      child: PreferenceBuilder<String>(
          preference: sharedPreferences.getString('user profile',
              defaultValue: 'assets/avatars/avatar 9.png'),
          builder: (context, snapshot) {
            return CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(
                snapshot,
              ),
            );
          }));
}

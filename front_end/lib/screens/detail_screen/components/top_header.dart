import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front_end/controllers/home_screen_controller.dart';
import 'package:front_end/controllers/wishlist_controller.dart';
import 'package:front_end/utils/constants.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import '../../../utils/colors.dart';
import '../../root_screen.dart';

class TopHeader extends StatelessWidget {
  final String productId;
  TopHeader({required this.productId});

  final WishListController wishListController = Get.find();
  final HomeScreenController homeScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Get.to(() => RootScreen()),
          child: SvgPicture.asset(
            'assets/images/Arrow - Left.svg',
            height: 25,
            color: darkBlue.withOpacity(0.7),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        PreferenceBuilder<List<String>>(
            preference:
                sharedPreferences.getStringList('favListIds', defaultValue: []),
            builder: (context, snapshot) {
              wishListController.ids = snapshot;
              return LikeButton(
                mainAxisAlignment: MainAxisAlignment.end,
                size: 20,
                isLiked: snapshot.contains(productId) ? true : false,
                circleColor: const CircleColor(
                  start: Colors.pink,
                  end: Colors.pink,
                ),
                bubblesColor: BubblesColor(
                  dotPrimaryColor: Colors.pink,
                  dotSecondaryColor: Colors.pink.withOpacity(0.5),
                ),
                likeBuilder: (bool isLiked) {
                  return isLiked
                      ? SvgPicture.asset(
                          'assets/images/Heart.svg',
                          color: Colors.pink,
                        )
                      : SvgPicture.asset(
                          'assets/images/Heart-Outline.svg',
                          color: Colors.black,
                        );
                },
                onTap: (isLiked) async {
                  isLiked
                      ? homeScreenController.favListIds.remove(productId)
                      : homeScreenController.favListIds.insert(0, productId);
                  await sharedPreferences.setStringList(
                    'favListIds',
                    homeScreenController.favListIds,
                  );
                  return !isLiked;
                },
              );
            }),
      ],
    );
  }
}

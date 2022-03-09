import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import '../../../controllers/home_screen_controller.dart';
import '../../../controllers/wishlist_controller.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';

class TopHeader extends StatelessWidget {
  final String productId;
  final bool isBannerProduct;
  TopHeader({required this.productId, required this.isBannerProduct});

  final WishListController wishListController = Get.find();
  final HomeScreenController homeScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: SvgPicture.asset(
            'assets/images/Arrow - Left.svg',
            height: 25,
            color: darkBlue.withOpacity(0.7),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        !isBannerProduct
            ? PreferenceBuilder<List<String>>(
                preference: sharedPreferences
                    .getStringList('favListIds', defaultValue: []),
                builder: (context, snapshot) {
                  wishListController.wishlistIds = snapshot;
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
                          ? wishListController.wishlistIds.remove(productId)
                          : wishListController.wishlistIds.insert(0, productId);
                      await sharedPreferences.setStringList(
                        'wishlistIds',
                        wishListController.wishlistIds,
                      );
                      return !isLiked;
                    },
                  );
                })
            : const SizedBox.shrink(),
      ],
    );
  }
}

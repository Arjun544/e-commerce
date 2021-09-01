import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../../controllers/profile_screen_controller.dart';
import '../../../utils/constants.dart';

void avatarsDialogue(
    BuildContext context, ProfileScreenController controller, bool setAvatar) {
  showGeneralDialog(
    barrierLabel: 'Barrier',
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 150),
    context: context,
    pageBuilder: (_, __, ___) {
      return Align(
        alignment: Alignment.center,
        child: Container(
          height: Get.height * 0.65,
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: SizedBox.expand(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Choose Avatar',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Double tap to finalize selection',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: StaggeredGridView.countBuilder(
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 25),
                      itemCount: controller.avatars.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Obx(
                          () => GestureDetector(
                            onTap: () {
                              controller.currentAvatar.value = index;
                            },
                            onDoubleTap: () async {
                              //saving avatar path in local storage
                              await sharedPreferences.setString(
                                  'user profile',
                                  controller
                                      .avatars[controller.currentAvatar.value]);
                              setAvatar = true;
                              Get.back();
                              Get.back();
                            },
                            child: Container(
                              height: Get.height * 0.2,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                border: controller.currentAvatar.value == index
                                    ? Border.all(width: 3, color: Colors.blue)
                                    : Border.all(
                                        width: 0,
                                        color: Colors.transparent,
                                      ),
                              ),
                              child: Image.asset(
                                controller.avatars[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                      staggeredTileBuilder: (index) {
                        return StaggeredTile.count(1, index.isEven ? 1.2 : 1.2);
                      }),
                ),
              ],
            ),
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      return SlideTransition(
        position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
            .animate(anim),
        child: child,
      );
    },
  );
}

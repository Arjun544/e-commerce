import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import '../../../controllers/profile_screen_controller.dart';
import '../../../models/userModel.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../widgets/custom_button.dart';
import '../../register_screen/register_screen.dart';
import 'avatar_bottomSheet.dart';
import 'avatars_dialogue.dart';

class UserImage extends StatelessWidget {
  final ProfileScreenController controller;
  final UserModel? currentUser;
  const UserImage(
      {required this.controller, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            getStorage.read('isLogin') == true
                ? currentUser!.data!.profile == ''
                    ? PreferenceBuilder<String>(
                        preference: sharedPreferences.getString('user profile',
                            defaultValue: 'assets/avatars/avatar 9.png'),
                        builder: (context, snapshot) {
                          return CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(
                              snapshot,
                            ),
                          );
                        })
                    : Obx(
                        () => CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                          currentUser!.data!.profile,
                        )),
                      )
                : PreferenceBuilder<String>(
                    preference: sharedPreferences.getString('user profile',
                        defaultValue: 'assets/avatars/avatar 9.png'),
                    builder: (context, snapshot) {
                      return CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(
                          snapshot,
                        ),
                      );
                    }),
            Container(
              height: 30,
              width: 30,
              margin: const EdgeInsets.only(bottom: 5),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: darkBlue,
              ),
              child: IconButton(
                onPressed: () async {
                  await avatarBottomSheet(
                    onAvatarPressed: () {
                      avatarsDialogue(context, controller);
                    },
                    ongalleryPressed: () {},
                  );
                },
                icon: SvgPicture.asset(
                  'assets/images/Pen.svg',
                  height: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        getStorage.read('isLogin') == true
            ? Text(
               currentUser!.data!.username,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )
            : CustomButton(
                height: 40,
                width: Get.width * 0.3,
                text: 'Log In',
                color: darkBlue,
                onPressed: () async {
                  await Get.to(() => RegisterScreen());
                },
              ),
      ],
    );
  }
}

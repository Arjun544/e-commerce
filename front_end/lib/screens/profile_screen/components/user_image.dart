import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import '../../../controllers/profile_screen_controller.dart';
import '../../../models/userModel.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../widgets/customDialogue.dart';
import '../../../widgets/custom_button.dart';
import '../../register_screen/register_screen.dart';
import 'avatar_bottomSheet.dart';
import 'avatars_dialogue.dart';

class UserImage extends StatefulWidget {
  final ProfileScreenController controller;
  final UserModel? currentUser;
  UserImage({required this.controller, this.currentUser});

  @override
  _UserImageState createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  final ImagePicker imagePicker = ImagePicker();

  File? pickedImage;
  bool isPicked = false;
  bool setAvatar = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            getStorage.read('isLogin') == true
                ? isPicked == true
                    ? CircleAvatar(
                        radius: 50,
                        backgroundImage: FileImage(pickedImage!),
                      )
                    : setAvatar
                        ? PreferenceBuilder<String>(
                            preference: sharedPreferences.getString(
                                'user profile',
                                defaultValue: 'assets/avatars/avatar 9.png'),
                            builder: (context, snapshot) {
                              return CircleAvatar(
                                radius: 50,
                                backgroundImage: AssetImage(
                                  snapshot,
                                ),
                              );
                            })
                        : widget.currentUser!.data.profile == ''
                            ? PreferenceBuilder<String>(
                                preference: sharedPreferences.getString(
                                    'user profile',
                                    defaultValue:
                                        'assets/avatars/avatar 9.png'),
                                builder: (context, snapshot) {
                                  return CircleAvatar(
                                    radius: 50,
                                    backgroundImage: AssetImage(
                                      snapshot,
                                    ),
                                  );
                                })
                            : CircleAvatar(
                                radius: 50,
                                backgroundImage: CachedNetworkImageProvider(
                                  widget.currentUser!.data.profile,
                                ),
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
                      avatarsDialogue(context, widget.controller, setAvatar);
                    },
                    onCameraPressed: getStorage.read('isLogin') == true
                        ? () async {
                            Get.back();
                            XFile? image = await imagePicker.pickImage(
                                source: ImageSource.camera,
                                imageQuality: 50,
                                preferredCameraDevice: CameraDevice.front);
                            if (image != null) {
                              await EasyLoading.show(
                                  status: 'updating...', dismissOnTap: false);
                              await EasyLoading.dismiss();
                              await widget.controller
                                  .updateImage(imageUrl: File(image.path));
                              setState(() {
                                pickedImage = File(image.path);
                                isPicked = true;
                                setAvatar = false;
                              });
                            }
                          }
                        : () {
                            AccessDialogue(context);
                          },
                    ongalleryPressed: getStorage.read('isLogin') == true
                        ? () async {
                            Get.back();
                            XFile? image = await imagePicker.pickImage(
                                source: ImageSource.gallery,
                                imageQuality: 50,
                                preferredCameraDevice: CameraDevice.front);
                            if (image != null) {
                              await widget.controller
                                  .updateImage(imageUrl: File(image.path));
                              setState(() {
                                pickedImage = File(image.path);
                                isPicked = true;
                                setAvatar = false;
                              });
                            }
                          }
                        : () {
                            AccessDialogue(context);
                          },
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
              toBeginningOfSentenceCase(
                      widget.currentUser!.data.username) ??
                  '',
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

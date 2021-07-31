import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/colors.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Future avatarBottomSheet(
    {required VoidCallback onAvatarPressed,
    required VoidCallback ongalleryPressed}) async {
  return Get.bottomSheet(
    Container(
      height: 150,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () => onAvatarPressed(),
            child: Container(
              margin: EdgeInsets.only(
                right: Get.width * 0.05,
                left: Get.width * 0.05,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: Container(
                  height: Get.height * 0.057,
                  width: Get.width * 0.12,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: darkBlue,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: SvgPicture.asset(
                    'assets/images/Profile.svg',
                    height: 25,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  toBeginningOfSentenceCase('Choose avatar') ?? '',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Get.height * 0.02,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => ongalleryPressed(),
            child: Container(
              margin: EdgeInsets.only(
                right: Get.width * 0.05,
                left: Get.width * 0.05,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: Container(
                  height: Get.height * 0.057,
                  width: Get.width * 0.12,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: customYellow,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: SvgPicture.asset(
                    'assets/images/Gallery.svg',
                    height: 25,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  toBeginningOfSentenceCase('Choose from gallery') ?? '',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Get.height * 0.02,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

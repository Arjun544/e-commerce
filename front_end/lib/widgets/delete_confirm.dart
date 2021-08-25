import 'package:flutter/material.dart';
import '../screens/register_screen/register_screen.dart';
import '../utils/colors.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'custom_button.dart';

void DeleteDialogue(BuildContext context, VoidCallback onPressed) {
  showGeneralDialog(
    barrierLabel: 'Barrier',
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 150),
    context: context,
    pageBuilder: (_, __, ___) {
      return Align(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              height: Get.height * 0.25,
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: SizedBox.expand(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Do you want to delete',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomButton(
                          height: 40,
                          width: Get.width * 0.3,
                          text: 'Cancel',
                          textColor: Colors.black,
                          color: Colors.grey.withOpacity(0.2),
                          onPressed: () => Get.back(),
                        ),
                        CustomButton(
                          height: 40,
                          width: Get.width * 0.3,
                          text: 'Delete',
                          color: Colors.red,
                          onPressed: onPressed,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              padding: const EdgeInsets.only(right: 40),
              onPressed: () {
                Get.back();
              },
              color: Colors.grey,
              icon: const Icon(Icons.close_rounded),
            ),
          ],
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

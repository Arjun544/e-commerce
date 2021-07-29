import 'package:flutter/material.dart';
import '../screens/register_screen/register_screen.dart';
import '../utils/colors.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'custom_button.dart';

void customDialogue(BuildContext context) {
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
              height: Get.height * 0.5,
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: SizedBox.expand(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Lottie.asset('assets/lock.json', height: Get.height * 0.17),
                    Column(
                      children: [
                        const Text(
                          'Access denied!',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const Text(
                          'log in to get access',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                    CustomButton(
                      height: 50,
                      width: Get.width * 0.6,
                      text: 'Log In',
                      color: customYellow,
                      onPressed: () async {
                        await Get.to(() => RegisterScreen());
                      },
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

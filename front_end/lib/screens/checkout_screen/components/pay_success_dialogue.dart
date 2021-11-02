import 'package:flutter/material.dart';
import 'package:front_end/screens/root_screen.dart';
import 'package:front_end/utils/colors.dart';
import 'package:front_end/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

void PaySuccessDialogue(BuildContext context) {
  showGeneralDialog(
    barrierLabel: 'Barrier',
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 150),
    context: context,
    pageBuilder: (_, __, ___) {
      return Align(
        alignment: Alignment.center,
        child: Container(
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
                Lottie.asset(
                  'assets/payment-successful.json',
                  height: Get.height * 0.17,
                  repeat: false,
                ),
                const Text(
                  'Payment Sucessful',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                CustomButton(
                  height: 50,
                  width: Get.width * 0.6,
                  text: 'Back Home',
                  color: customYellow,
                  onPressed: () async {
                    await Get.to(
                      () => RootScreen(),
                    );
                  },
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

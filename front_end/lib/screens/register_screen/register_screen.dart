import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../controllers/register_screen_controller.dart';
import 'components/signup_view.dart';
import '../../utils/colors.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import 'package:lottie/lottie.dart';

import 'components/login_view.dart';

class RegisterScreen extends StatelessWidget {
  final RegisterScreenController registerScreenController =
      Get.put(RegisterScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 30,
                left: 0,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.close_rounded,
                    size: 30,
                  ),
                ),
              ),
              Container(
                width: 500,
                child: Lottie.asset(
                  'assets/elements.json',
                  height: 200,
                ),
              ),
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(math.pi),
                child: RotatedBox(
                  quarterTurns: 5,
                  child: SvgPicture.asset(
                    'assets/images/Activity.svg',
                    color: customYellow,
                    height: 70,
                  ),
                ),
              ),
            ],
          ),
          Obx(
            () => Column(
              children: [
                CustomSlidingSegmentedControl(
                  fixedWidth: 150,
                  elevation: 5,
                  radius: 15,
                  innerPadding: 5,
                  backgroundColor: Colors.grey.withOpacity(0.2),
                  children: {
                    1: const Text(
                      'Log In',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    2: const Text(
                      'Sign Up',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  },
                  onValueChanged: (int v) {
                    registerScreenController.currentTab.value = v;
                  },
                ),
                registerScreenController.currentTab.value == 1
                    ? const LoginView()
                    : const SignupView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
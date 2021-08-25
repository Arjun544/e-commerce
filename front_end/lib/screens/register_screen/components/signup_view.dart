import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/register_screen_controller.dart';
import '../../../utils/colors.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/email_textField.dart';
import '../../../widgets/pass_textField.dart';

class SignupView extends StatelessWidget {
  final RegisterScreenController controller =
      Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height - 280,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Create an account',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const Text(
                      "Provide valid email, We'll send verification code!",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              EmailTextField(
                controller: controller.usernameController,
                text: 'Username',
                icon: 'assets/images/Profile.svg',
              ),
              const SizedBox(height: 20),
              EmailTextField(
                controller: controller.emailController,
                text: 'Email',
                icon: 'assets/images/Message.svg',
              ),
              const SizedBox(height: 20),
              PassTextField(
                  width: Get.width * 0.85,
                controller: controller.passController,
                registerScreenController: controller,
                text: 'Password',
                icon: 'assets/images/Lock.svg',
              ),
              const SizedBox(height: 20),
              PassTextField(
               width: Get.width * 0.85,
                controller: controller.confirmPassController,
                registerScreenController: controller,
                text: 'Confirm Password',
                icon: 'assets/images/Lock.svg',
              ),
            ],
          ),
          CustomButton(
            height: 50,
            width: Get.width * 0.5,
            text: 'Sign Up',
            color: darkBlue,
            onPressed: () async {
              await controller.signUp();
              controller.emailController.clear();
              controller.passController.clear();
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'forget_password.dart';
import 'package:get/get.dart';

import '../../../controllers/register_screen_controller.dart';
import '../../../utils/colors.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/email_textField.dart';
import '../../../widgets/pass_textField.dart';

class LoginView extends StatelessWidget {
  final RegisterScreenController controller = Get.find();

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
              const Padding(
                padding: EdgeInsets.only(left: 25),
                child: Text(
                  'Hey, Welcome back',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
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
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 25, top: 10),
                  child: InkWell(
                    onTap: () => Get.to(() => ForgetPassWord()),
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          CustomButton(
            height: 50,
            width: Get.width * 0.5,
            text: 'Log In',
            color: darkBlue,
            onPressed: () async {
              await controller.signIn();
            },
          ),
          Column(
            children: [
              // SocialButton(
              //   height: 50,
              //   width: Get.width * 0.85,
              //   text: 'Continue with Phone',
              //   icon: 'assets/images/Call.svg',
              //   color: customYellow,
              //   iconColor: Colors.white,
              //   onPressed: (){},
              // ),
              // const SizedBox(height: 10),
              // SocialButton(
              //   height: 50,
              //   width: Get.width * 0.85,
              //   text: 'Continue with Google',
              //   icon: 'assets/images/Google.svg',
              //   color: const Color(0xFFA2DBFA),
              //   onPressed: () async {
              //     await controller.signinWIthGoogle();
              //   },
              // ),
              // const SizedBox(height: 25),
            ],
          ),
        ],
      ),
    );
  }
}

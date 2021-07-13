import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/social_btn.dart';
import 'package:get/get.dart';
import '../../../widgets/email_textField.dart';
import '../../../widgets/pass_textField.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

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
                text: 'Email',
                icon: 'assets/images/Message.svg',
              ),
              const SizedBox(height: 20),
              PassTextField(
                text: 'Password',
                icon: 'assets/images/Lock.svg',
              ),
              const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 25, top: 10),
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.grey,
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
          ),
          Column(
            children: [
              SocialButton(
                height: 50,
                width: Get.width * 0.85,
                text: 'Continue with Phone',
                icon: 'assets/images/Call.svg',
                color: customYellow,
                iconColor: Colors.white,
              ),
              const SizedBox(height: 10),
              SocialButton(
                height: 50,
                width: Get.width * 0.85,
                text: 'Continue with Google',
                icon: 'assets/images/Google.svg',
                color: const Color(0xFFA2DBFA),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

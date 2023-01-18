import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';

import '../../../controllers/profile_screen_controller.dart';
import '../../../controllers/register_screen_controller.dart';
import '../../../utils/colors.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/pass_textField.dart';
import 'top_header.dart';

class ResetPassword extends StatelessWidget {
  final String currentUserEmail;

  ResetPassword({Key? key, required this.currentUserEmail}) : super(key: key);
  final ProfileScreenController profileScreenController = Get.find();

  final RegisterScreenController registerScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 40),
        child: const TopHeader(text: 'Reset Password'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Lottie.asset('assets/email.json', height: Get.height * 0.15),
              Text(
                'Pin has been sent to \n $currentUserEmail',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Pinput(
                  length: 6,
                  animationDuration: const Duration(milliseconds: 200),
                  onSubmitted: (String pin) {
                    profileScreenController.pinController.text = pin;
                  },
                  obscureText: true,
                  obscuringCharacter: '*',
                  pinAnimationType: PinAnimationType.slide,
                  defaultPinTheme: const PinTheme(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // focusNode: _pinPutFocusNode,
                  controller: profileScreenController.pinController,
                  submittedPinTheme:PinTheme(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        width: 2,
                        color: customYellow,
                      ),
                    ),
                  ), 
                  focusedPinTheme: PinTheme(
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      width: 2,
                      color: customYellow,
                    ),
                  ),
                  ),
                  followingPinTheme: PinTheme(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        width: 2,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                PassTextField(
                  width: Get.width * 0.85,
                  controller: profileScreenController.newPassController,
                  registerScreenController: registerScreenController,
                  text: 'New password',
                  icon: 'assets/images/Lock.svg',
                ),
                const SizedBox(
                  height: 20,
                ),
                PassTextField(
                  width: Get.width * 0.85,
                  controller: profileScreenController.confirmPassController,
                  registerScreenController: registerScreenController,
                  text: 'confirm password',
                  icon: 'assets/images/Lock.svg',
                ),
              ],
            ),
          ),
          Column(
            children: [
              InkWell(
                onTap: () async {
                  await profileScreenController.forgetPassowrd(
                      email: currentUserEmail);
                },
                child: const Text(
                  'Send Again',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.green,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                height: 50,
                width: Get.width * 0.8,
                text: 'Submit',
                color: darkBlue,
                onPressed: () async {
                  if (profileScreenController.pinController.text.length < 6 ||
                      profileScreenController.newPassController.text.isEmpty ||
                      profileScreenController
                          .confirmPassController.text.isEmpty) {
                    await EasyLoading.showToast(
                      'All fields are required',
                      toastPosition: EasyLoadingToastPosition.top,
                      maskType: EasyLoadingMaskType.clear,
                    );
                  } else {
                    await profileScreenController.resetPassword(
                      code: profileScreenController.pinController.text,
                      newPassword:
                          profileScreenController.newPassController.text,
                      confirmPassword:
                          profileScreenController.confirmPassController.text,
                    );
                    Get.back();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

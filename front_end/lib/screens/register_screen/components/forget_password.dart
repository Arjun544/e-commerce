import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:front_end/controllers/profile_screen_controller.dart';
import 'package:front_end/screens/profile_screen/components/reset_password.dart';
import 'package:front_end/screens/profile_screen/components/top_header.dart';
import 'package:front_end/widgets/email_textField.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../controllers/register_screen_controller.dart';
import '../../../utils/colors.dart';
import '../../../widgets/custom_button.dart';

class ForgetPassWord extends StatefulWidget {
  ForgetPassWord({Key? key}) : super(key: key);

  @override
  State<ForgetPassWord> createState() => _ForgetPassWordState();
}

class _ForgetPassWordState extends State<ForgetPassWord> {
  final RegisterScreenController registerScreenController = Get.find();
  final ProfileScreenController profileScreenController = Get.find();
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size(Get.width, 40),
          child: const TopHeader(text: 'Forget Password'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Lottie.asset('assets/email.json', height: Get.height * 0.15),
                const Text(
                  'Please enter your email to \n reset your password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            EmailTextField(
              controller: textEditingController,
              text: 'Email',
              icon: 'assets/images/Message.svg',
            ),
            CustomButton(
              height: 50,
              width: Get.width * 0.8,
              text: 'Submit',
              color: darkBlue,
              onPressed: () async {
                if (textEditingController.text.isEmpty) {
                  await EasyLoading.showToast(
                    'Email cannot be empty',
                    toastPosition: EasyLoadingToastPosition.top,
                    maskType: EasyLoadingMaskType.clear,
                  );
                } else {
                  var response = await profileScreenController.forgetPassowrd(
                      email: textEditingController.text);

                  if (response == 'User not found') {
                    await EasyLoading.showToast(
                      'User not found',
                      toastPosition: EasyLoadingToastPosition.top,
                    );
                  } else {
                    await Get.to(
                      () => ResetPassword(
                        currentUserEmail: textEditingController.text,
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

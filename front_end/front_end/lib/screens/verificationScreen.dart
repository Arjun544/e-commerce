import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/colors.dart';
import '../widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pin_put/pin_put.dart';

class VerificationScreen extends StatelessWidget {
  final TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 45),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: SvgPicture.asset(
                    'assets/images/Arrow - Left.svg',
                    height: 25,
                    color: darkBlue.withOpacity(0.7),
                  ),
                ),
                const Text(
                  'Verification',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
            Column(
              children: [
                Lottie.asset('assets/email.json', height: Get.height * 0.25),
                const Text(
                  'Enter the verification code, We just sent to your email address',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: PinPut(
                fieldsCount: 6,
                animationDuration: const Duration(milliseconds: 200),
                onSubmit: (String pin) {},
                checkClipboard: true,
                obscureText: '*',
                pinAnimationType: PinAnimationType.slide,
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                // focusNode: _pinPutFocusNode,
                controller: pinController,

                submittedFieldDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    width: 2,
                    color: customYellow,
                  ),
                ),
                selectedFieldDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    width: 2,
                    color: customYellow,
                  ),
                ),
                followingFieldDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    width: 2,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                const Text(
                  'Send Again',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 15),
                CustomButton(
                  height: 50,
                  width: Get.width * 0.8,
                  text: 'Submit',
                  color: darkBlue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

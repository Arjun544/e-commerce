import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:front_end/screens/verificationScreen.dart';
import 'package:get/get.dart';

class RegisterScreenController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  RxInt currentTab = 1.obs;
  RxBool isPasswordHide = true.obs;

  Dio dio = Dio();

  final String baseUrl = 'https://sell-corner.herokuapp.com/api/';

  void togglePassword() {
    isPasswordHide.value = !isPasswordHide.value;
  }

  Future<void> signUp() async {
    await EasyLoading.show(status: 'loading...', dismissOnTap: false);
    Map data = {
      'username': usernameController.text,
      'email': emailController.text,
      'password': passController.text,
      'confirmPassword': confirmPassController.text,
    };
    try {
      var response = await dio.post(
        baseUrl + 'users/register',
        data: data,
      );

      log(response.data.toString());
      if (response.data['error'] == true) {
        // ignore: unawaited_futures
        EasyLoading.showToast(
          response.data['message'],
          toastPosition: EasyLoadingToastPosition.top,
          maskType: EasyLoadingMaskType.clear,
        );
      } else {
        await Get.to(() => VerificationScreen());
      }

      await EasyLoading.dismiss();
    } catch (e) {
      Get.snackbar('Something is wrong', e.toString(),
          snackPosition: SnackPosition.TOP);
    }
  }
}

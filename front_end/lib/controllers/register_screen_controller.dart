import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:front_end/screens/home_screen/home_screen.dart';
import 'package:front_end/screens/register_screen/register_screen.dart';
import 'package:front_end/widgets/custom_snackbar.dart';
import 'package:get_storage/get_storage.dart';
import '../screens/verificationScreen.dart';
import 'package:get/get.dart';

class RegisterScreenController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
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
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
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
        await EasyLoading.dismiss();
        await Get.to(() => VerificationScreen());
      }
    } catch (e) {
      Get.snackbar('Something is wrong', e.toString(),
          snackPosition: SnackPosition.TOP);
      print(e);
    }
  }

  Future<void> VerifyEmail() async {
    await EasyLoading.show(status: 'loading...', dismissOnTap: false);
    Map data = {
      'email': emailController.text,
      'code': pinController.text,
    };
    try {
      var response = await dio.patch(
        baseUrl + 'users/activate',
        data: data,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      log(response.data.toString());
      if (response.data['error'] == true) {
        await EasyLoading.showToast(
          response.data['message'],
          toastPosition: EasyLoadingToastPosition.top,
          maskType: EasyLoadingMaskType.clear,
        );
      } else {
        await EasyLoading.dismiss();

        await EasyLoading.showToast(
          'Successfully verified, Login now',
          toastPosition: EasyLoadingToastPosition.top,
          maskType: EasyLoadingMaskType.clear,
        );
        currentTab.value = 1;
        await Get.offAll(() => RegisterScreen());
      }
    } catch (e) {
      Get.snackbar('Something is wrong', e.toString(),
          snackPosition: SnackPosition.TOP);
      print(e);
    }
  }

  Future<void> signIn() async {
    await EasyLoading.show(status: 'loading...', dismissOnTap: false);
    Map data = {
      'email': emailController.text,
      'password': passController.text,
    };
    try {
      var response = await dio.post(
        baseUrl + 'users/login',
        data: data,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
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
        log(response.data);
        // Saveing jwt token in local storage
        await GetStorage().write('token', response.data['token']);
        await EasyLoading.dismiss();
        await Get.to(() => HomeScreen());
      }
    } catch (e) {
      Get.snackbar('Something is wrong', e.toString(),
          snackPosition: SnackPosition.TOP);
      print(e);
    }
  }
}

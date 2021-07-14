import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegisterScreenController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  RxInt currentTab = 1.obs;
  RxBool isPasswordHide = true.obs;

  void togglePassword() {
    isPasswordHide.value = !isPasswordHide.value;
  }
}

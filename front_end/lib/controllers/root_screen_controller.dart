import 'dart:developer';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../models/userModel.dart';
import '../utils/constants.dart';
import 'package:get/get.dart';

import 'register_screen_controller.dart';

class RootScreenController extends GetxController {
  final RegisterScreenController registerScreenController =
      Get.put(RegisterScreenController());

  RxInt currentIndex = 0.obs;
  RxBool isLogIn = false.obs;
  Rx<UserModel>? currentUser = UserModel().obs;

  @override
  void onReady() async {
    isLogIn.value = await getStorage.read('isLogin');
    if (isLogIn.value == true) {
      await getCurrentUser();
    }
    super.onReady();
  }

  void updateIndex(int value) {
    currentIndex.value = value;
  }

  Future<UserModel?> getCurrentUser() async {
    await EasyLoading.show(status: 'loading...', dismissOnTap: false);

    try {
      var response = await dio.get(
        baseUrl + 'users/${registerScreenController.currentUserId}',
      );
      if (response.data['error'] == true) {
        // ignore: unawaited_futures
        EasyLoading.showToast(
          response.data['message'],
          toastPosition: EasyLoadingToastPosition.top,
          maskType: EasyLoadingMaskType.clear,
        );
      } else {
        currentUser?.value = UserModel.fromJson(response.data);
        log('current user ${currentUser?.value.data?.username.toString()}');
        await EasyLoading.dismiss();
      }
    } catch (e) {
      Get.snackbar('Something is wrong', e.toString(),
          snackPosition: SnackPosition.TOP);
      print(e);
    }
  }
}

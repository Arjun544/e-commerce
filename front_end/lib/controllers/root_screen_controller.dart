import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:front_end/controllers/cart_screen_controller.dart';
import 'package:rxdart/rxdart.dart';
import '../models/userModel.dart';
import '../utils/constants.dart';
import 'package:get/get.dart';

import 'register_screen_controller.dart';

class RootScreenController extends GetxController {
  final RegisterScreenController registerScreenController =
      Get.put(RegisterScreenController());

  RxInt currentIndex = 0.obs;

  final StreamController<UserModel> currentUserController = BehaviorSubject();

  @override
  void onInit() async {
    if (getStorage.read('isLogin') == true) {
      await getCurrentUser();
    }
    super.onInit();
  }

  void updateIndex(int value) {
    currentIndex.value = value;
  }

  Future<UserModel?> getCurrentUser() async {

    try {
      var response = await dio.get(
        baseUrl + 'users/60f32dd949b3d700150f5899',
        options: Options(
          responseType: ResponseType.plain,
        ),
      );
      
        currentUserController.add(userModelFromJson(response.data));
        log('current user ${response.data.toString()}');
       
      
    } catch (e) {
      Get.snackbar('Something is wrong', e.toString(),
          snackPosition: SnackPosition.TOP);
      print(e);
    }
  }

  @override
  void onClose() {
    currentUserController.close();
    super.onClose();
  }
}

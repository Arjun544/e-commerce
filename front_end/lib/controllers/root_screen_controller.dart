import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../models/userModel.dart';
import '../utils/constants.dart';
import 'register_screen_controller.dart';

class RootScreenController extends GetxController {
  ScrollController hideBottomNavController = ScrollController();
  final RegisterScreenController registerScreenController =
      Get.put(RegisterScreenController());

  RxInt currentIndex = 0.obs;
  RxBool isBottomBarVisible = true.obs;

  final StreamController<UserModel> currentUserStreamController =
      BehaviorSubject();

  void updateBottomBarStatus(val) {
    isBottomBarVisible.value = val;
  }

  void updateIndex(int value) {
    currentIndex.value = value;
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      var response = await dio.get(
        baseUrl + 'users/${getStorage.read('userId')}',
        options: Options(
          responseType: ResponseType.plain,
        ),
      );
      if (response.statusCode == 400) {
        await EasyLoading.showToast(
          response.data,
          toastPosition: EasyLoadingToastPosition.top,
          maskType: EasyLoadingMaskType.clear,
        );
      }
      currentUserStreamController.add(userModelFromJson(response.data));
      return userModelFromJson(response.data);
    } catch (e) {
      await EasyLoading.dismiss();
      await EasyLoading.showToast(
        'Something went wrong',
        toastPosition: EasyLoadingToastPosition.top,
        maskType: EasyLoadingMaskType.clear,
      );
      print(e);
    }
    return null;
  }
}

import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
      log(response.data.toString());
      currentUserStreamController.add(userModelFromJson(response.data));
    } catch (e) {
      Get.snackbar('Something is wrong', e.toString(),
          snackPosition: SnackPosition.TOP);
      print(e);
    }
  }
}

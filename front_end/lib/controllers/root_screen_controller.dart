import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../models/userModel.dart';
import '../utils/constants.dart';
import 'register_screen_controller.dart';

class RootScreenController extends GetxController {
  final RegisterScreenController registerScreenController =
      Get.put(RegisterScreenController());

  RxInt currentIndex = 0.obs;

  final StreamController<UserModel> currentUserStreamController =
      BehaviorSubject();

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

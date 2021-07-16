import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:front_end/models/userModel.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeScreenController extends GetxController {
  PageController salesPageController = PageController(initialPage: 0);

  final String baseUrl = 'https://sell-corner.herokuapp.com/api/';
  final GetStorage getStorage = GetStorage();
  Dio dio = Dio();
  int _currentPage = 0;

  late UserModel? currentUser;

  @override
  void onReady() async {
    await getCurrentUser().then((value) => currentUser = value);
    Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (salesPageController.hasClients) {
        salesPageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.bounceInOut,
        );
      }
      ;
    });
    super.onReady();
  }

  Future<UserModel?> getCurrentUser() async {
    await EasyLoading.show(status: 'loading...', dismissOnTap: false);

    try {
      // get token
      String token = await getStorage.read('token');
      var response;

      response = await dio.get(
        baseUrl + 'users/currentUser',
        options: Options(),
      );
      if (response.statusCode == 200) {
        print(response.data);
        return UserModel.fromJson(response.data);
      }
      await EasyLoading.dismiss();
    } catch (e) {
      Get.snackbar('Something is wrong', e.toString(),
          snackPosition: SnackPosition.TOP);
      print(e);
    }
  }

  @override
  void dispose() {
    salesPageController.dispose();
    super.dispose();
  }
}

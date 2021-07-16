import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:front_end/controllers/register_screen_controller.dart';
import 'package:front_end/models/featuredProduct_Model.dart';
import 'package:front_end/utils/constants.dart';
import '../models/userModel.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  PageController salesPageController = PageController(initialPage: 0);
  final RegisterScreenController registerScreenController =
      Get.put(RegisterScreenController());

  int _currentPage = 0;
  RxBool isLogIn = false.obs;

  Rx<UserModel>? currentUser = UserModel().obs;
  var featuredProducts = <FeaturedProductModel>[].obs;

  @override
  void onReady() async {
    await getStorage.read('isLogin');
    if (isLogIn.value == true) {
      await getCurrentUser();
    }
    var products = await getFeaturedProducts();
    if (products != null) {
      featuredProducts.add(products);
    }
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
        log(response.data.toString());
        currentUser?.value = UserModel.fromJson(response.data);
        log('cyrent user ${currentUser?.value.data?.username.toString()}');
        await EasyLoading.dismiss();
      }
    } catch (e) {
      Get.snackbar('Something is wrong', e.toString(),
          snackPosition: SnackPosition.TOP);
      print(e);
    }
  }

  Future<FeaturedProductModel?> getFeaturedProducts() async {
    await EasyLoading.show(status: 'loading...', dismissOnTap: false);

    try {
      var response = await dio.get(
        baseUrl + 'products/featured',
      );
      if (response.data['error'] == true) {
        // ignore: unawaited_futures
        EasyLoading.showToast(
          response.data['message'],
          toastPosition: EasyLoadingToastPosition.top,
          maskType: EasyLoadingMaskType.clear,
        );
      } else {
        log(response.data.toString());
        await EasyLoading.dismiss();
        return FeaturedProductModel.fromJson(response.data);
      }
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

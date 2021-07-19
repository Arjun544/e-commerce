import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'register_screen_controller.dart';
import '../models/product_Model.dart';
import '../utils/constants.dart';
import '../models/userModel.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  PageController salesPageController = PageController(initialPage: 0);
  final RegisterScreenController registerScreenController =
      Get.put(RegisterScreenController());

  int _currentPage = 0;
  RxBool isLogIn = false.obs;

  Rx<UserModel>? currentUser = UserModel().obs;
  StreamController<ProductModel> featuredProductsStreamController =
      StreamController<ProductModel>();
  StreamController<ProductModel> arrivalProductsStreamController =
      StreamController<ProductModel>();

  @override
  void onReady() async {
    await getStorage.read('isLogin');
    if (isLogIn.value == true) {
      await getCurrentUser();
    }
    await getData();
    // featuredProducts.value = await getFeaturedProducts();
    // newArrivalProducts.value = await getnewArrivalsProducts();

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

  Future getData() async {
    await EasyLoading.show(status: 'loading...', dismissOnTap: false);

    try {
      var arrivalResponse = await dio.get(
        baseUrl + 'products/newArrival',
        options: Options(
          responseType: ResponseType.plain,
        ),
      );
      var featuredResponse = await dio.get(
        baseUrl + 'products/featured',
        options: Options(
          responseType: ResponseType.plain,
        ),
      );

      arrivalProductsStreamController.add(arrivalResponse.data);

      featuredProductsStreamController.add(featuredResponse.data);
      await EasyLoading.dismiss();
    } catch (e) {
      Get.snackbar('Something is wrong', e.toString(),
          snackPosition: SnackPosition.TOP);
      print(e);
    }
  }

  Future<List<ProductModel>> getnewArrivalsProducts() async {
    await EasyLoading.show(status: 'loading...', dismissOnTap: false);

    try {
      var response = await dio.get(
        baseUrl + 'products/newArrival',
        options: Options(
          responseType: ResponseType.plain,
        ),
      );
      log(response.data.toString());
      await EasyLoading.dismiss();
      return productModelFromJson(response.data.toString());
    } catch (e) {
      Get.snackbar('Something is wrong', e.toString(),
          snackPosition: SnackPosition.TOP);
      print(e);
      return [];
    }
  }

  @override
  void dispose() {
    salesPageController.dispose();
    super.dispose();
  }
}

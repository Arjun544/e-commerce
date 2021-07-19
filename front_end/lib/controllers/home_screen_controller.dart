import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rxdart/rxdart.dart' as rxDart;
import 'register_screen_controller.dart';
import '../models/product_Model.dart';
import '../utils/constants.dart';
import '../models/userModel.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  PageController salesPageController = PageController(initialPage: 0);

  int _currentPage = 0;

  final StreamController<ProductModel> featuredProductsStreamController =
      rxDart.BehaviorSubject();
  final StreamController<ProductModel> arrivalProductsStreamController =
      rxDart.BehaviorSubject();

  @override
  void onReady() async {
    
    await getData();

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

  @override
  void onClose() {
    arrivalProductsStreamController.close();
    featuredProductsStreamController.close();
    super.onClose();
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

      arrivalProductsStreamController
          .add(productModelFromJson(arrivalResponse.data));

      featuredProductsStreamController
          .add(productModelFromJson(featuredResponse.data));
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

import 'dart:async';

import 'package:flutter/material.dart';
import '../services/product_api.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../models/product_Model.dart';

class HomeScreenController extends GetxController {
  PageController salesPageController = PageController(initialPage: 0);

  int _currentPage = 0;

  final StreamController<ProductModel> featuredProductsStreamController =
      BehaviorSubject();
  final StreamController<ProductModel> arrivalProductsStreamController =
      BehaviorSubject();

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

  Future getData() async => await ApiProduct().getData(
        arrivalController: arrivalProductsStreamController,
        featuredController: featuredProductsStreamController,
      );

  @override
  void dispose() {
    salesPageController.dispose();
    super.dispose();
  }
}

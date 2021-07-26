import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../models/product_Model.dart';
import '../services/product_api.dart';

class HomeScreenController extends GetxController {
  final PageController salesPageController = PageController(initialPage: 0);
  List<String> favListIds = [];
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
      if (salesPageController.hasClients ||
          // ignore: invalid_use_of_protected_member
          salesPageController.positions.length > 1) {
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
    salesPageController.dispose();
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

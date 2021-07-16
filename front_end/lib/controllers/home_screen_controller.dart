import 'dart:async';

import 'package:flutter/material.dart';
import 'package:front_end/models/userModel.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  PageController salesPageController = PageController(initialPage: 0);
  int _currentPage = 0;

  late UserModel currentUser;

  @override
  void onReady() {
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
  void dispose() {
    salesPageController.dispose();
    super.dispose();
  }
}

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:front_end/controllers/root_screen_controller.dart';
import 'package:front_end/models/userModel.dart';
import 'package:front_end/services/cart_api.dart';
import 'package:front_end/utils/constants.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../models/category_model.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../models/product_Model.dart';
import '../services/product_api.dart';

class HomeScreenController extends GetxController {
  
  final PageController salesPageController = PageController(initialPage: 0);
  List<String> favListIds = [];
  int _currentPage = 0;
  RxBool isLoading = false.obs;
  late Socket socket;
  RxInt cartLength = 0.obs;
   

  final StreamController<CategoryModel> categoriesStreamController =
      BehaviorSubject();
  final StreamController<ProductModel> featuredProductsStreamController =
      BehaviorSubject();
  final StreamController<ProductModel> arrivalProductsStreamController =
      BehaviorSubject();
  final StreamController<ProductModel> searchStreamController =
      BehaviorSubject();

  @override
  void onReady() async {
    
    cartSocketInit();
    await getData();
    if (getStorage.read('isLogin') == true) {
      cartLength.value = await cartCount(userId: getStorage.read('userId'));
      log(cartLength.value.toString());
    }

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

  void cartSocketInit() {
    socket = io('http://192.168.0.107:4000',
        // 'https://sell-corner.herokuapp.com/',
        <String, dynamic>{
          'transports': ['websocket'],
          'autoConnect': false,
        });
    socket.connect();
    socket.onConnect((data) => print('sockeeeeeeeeet is connected'));
  }

  Future getData() async => await ApiProduct().getData(
        categoriesController: categoriesStreamController,
        arrivalController: arrivalProductsStreamController,
        featuredController: featuredProductsStreamController,
      );

  Future cartCount({required String userId}) async =>
      await ApiCart().cartCount(userId: userId);

  Future searchProduct({required String query}) async =>
      await ApiProduct().searchProduct(
        query: query,
        searchController: searchStreamController,
      );

  @override
  void dispose() {
    salesPageController.dispose();
    super.dispose();
  }
}

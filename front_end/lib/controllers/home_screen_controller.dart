import 'dart:async';

import 'package:flutter/material.dart';
import 'package:front_end/models/deal_model.dart';
import 'package:front_end/services/deal_api.dart';
import '../models/banner_model.dart';
import '../services/banners_api.dart';
import '../services/cart_api.dart';
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
  RxBool isBannersLoading = false.obs;
  RxBool isDealLoading = false.obs;
  late Socket socket;
  RxInt cartLength = 0.obs;

  var banners = BannerModel(success: true, banners: []).obs;
  var deals = DealModel(success: true, deals: []).obs;
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
    isBannersLoading.value = true;
    banners.value = await BannersApi().getBanners();
    isBannersLoading.value = false;
    isDealLoading.value = true;
    deals.value = await DealApi().getDeal();
    isDealLoading.value = false;
    await getData();

    if (banners.value.banners.length > 1) {
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
    }
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
    socket = io(
        'http://192.168.0.102:4000',
        // 'https://sell-corner.herokuapp.com/',
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .setExtraHeaders({'foo': 'bar'}) // optional
            .build());

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

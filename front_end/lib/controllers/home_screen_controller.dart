import 'dart:async';

import 'package:flutter/material.dart';
import '../models/deal_model.dart';
import '../services/deal_api.dart';
import '../models/banner_model.dart';
import '../services/banners_api.dart';
import '../services/cart_api.dart';
import '../models/category_model.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../models/product_Model.dart';
import '../services/product_api.dart';

class HomeScreenController extends GetxController {
  final PageController salesPageController = PageController(initialPage: 0);
  int _currentPage = 0;
  RxBool isBannersLoading = false.obs;
  RxBool isDealLoading = false.obs;
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
    isBannersLoading.value = true;
    banners.value = await BannersApi().getBanners();
    isBannersLoading.value = false;
    isDealLoading.value = true;
    deals.value = await DealApi().getDeal();
    isDealLoading.value = false;
    await getCategories();
    await getNewArrivalProducts(page: 1);
    await getFeaturedProducts(page: 1);

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

  void handleNewArrivalsPagination(int value) async {
    await getNewArrivalProducts(page: value);
  }

  void handleFeaturedPagination(int value) async {
    await getFeaturedProducts(page: value);
  }

  Future getCategories() async => await ApiProduct().getCategories(
        categoriesController: categoriesStreamController,
      );

  Future getNewArrivalProducts({required int page}) async =>
      await ApiProduct().getNewArrivalProducts(
        page: page,
        arrivalController: arrivalProductsStreamController,
      );

  Future getFeaturedProducts({required int page}) async =>
      await ApiProduct().getFeaturedProducts(
        page: page,
        featuredController: featuredProductsStreamController,
      );

  Future cartCount({required String userId}) async =>
      await ApiCart().cartCount(userId: userId);

  Future searchProduct({required int page, required String query}) async =>
      await ApiProduct().searchProduct(
        page: page,
        query: query,
        searchController: searchStreamController,
      );

  @override
  void dispose() {
    salesPageController.dispose();
    super.dispose();
  }
}

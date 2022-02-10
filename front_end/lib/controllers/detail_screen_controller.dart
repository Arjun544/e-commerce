import 'dart:async';

import 'package:flutter/material.dart';

import '../services/product_api.dart';

import '../models/product_Model.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class DetailScreenController extends GetxController {
  ScrollController hideAddCartController = ScrollController();
  final StreamController<ProductModel> similarProductsController =
      BehaviorSubject();

  RxInt currentImage = 5.obs;
  RxInt selected = 0.obs;
  RxBool firstTap = false.obs;
  late double averageRating;

  RxBool isAddCartVisible = true.obs;

  Future handleSimilarProductsPagination(
      {required int page, required productId, required categoryId}) async {
    await ApiProduct().getSimilarProducts(
        page: page,
        categoryId: categoryId,
        productId: productId,
        controller: similarProductsController);
  }

  void updateAddCartStatus(val) {
    isAddCartVisible.value = val;
  }

  void updateImage(int newImage) {
    currentImage.value = newImage;
  }

  Future getSimilarProducts(
      {required int page, required productId, required categoryId}) async {
    await ApiProduct().getSimilarProducts(
        page: page,
        categoryId: categoryId,
        productId: productId,
        controller: similarProductsController);
  }
}

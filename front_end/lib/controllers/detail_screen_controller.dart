import 'dart:async';

import 'package:flutter/material.dart';

import '../services/product_api.dart';

import '../models/product_Model.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class DetailScreenController extends GetxController {
  ScrollController hideAddCartController = ScrollController();
  final StreamController<ProductModel> similarProductsController = BehaviorSubject();

  RxInt currentImage = 0.obs;
  RxInt selected = 0.obs;
  RxBool firstTap = false.obs;
  late double averageRating;

  RxBool isAddCartVisible = true.obs;

  void updateAddCartStatus(val) {
    isAddCartVisible.value = val;
  }

  void updateImage(int newImage) {
    currentImage.value = newImage;
  }

  Future getSimilarProducts({required categoryId, required currentId}) async {
    await ApiProduct().getSimilarProducts(
        currentId: currentId,
        categoryId: categoryId,
        controller: similarProductsController);
  }
}

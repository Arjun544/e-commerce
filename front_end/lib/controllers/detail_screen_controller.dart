import 'dart:async';

import '../services/product_api.dart';

import '../models/product_Model.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class DetailScreenController extends GetxController {
  final StreamController<ProductModel> byCategoryController = BehaviorSubject();

  RxInt currentImage = 0.obs;
  RxInt selected = 0.obs;
  RxBool firstTap = false.obs;
  late double averageRating;

  void updateImage(int newImage) {
    currentImage.value = newImage;
  }

  Future getProductsByCategory({required categoryId, required currentId}) async {
    await ApiProduct().getProductsByCategory(
      currentId: currentId,
        categoryId: categoryId, controller: byCategoryController);
  }
}

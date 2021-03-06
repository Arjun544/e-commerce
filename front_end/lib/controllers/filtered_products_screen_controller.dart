import 'dart:async';

import '../services/product_api.dart';

import '../models/product_Model.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class FilteredProductsScreenController extends GetxController {
  final StreamController<ProductModel> filteredProductsStreamController =
      BehaviorSubject();

  RxList<Product> sortedProducts = <Product>[].obs;

  RxBool isSorting = false.obs;
  RxString appliedSort = ''.obs;

  List<Product> filteredProducts = [];

  Future getFilteredProducts(
          {required String id,
          required bool hasQueryParam,
          String? subCategory}) async =>
      await ApiProduct().getFilteredProducts(
        hasQueryParam: hasQueryParam,
        categoryId: id,
        controller: filteredProductsStreamController,
        subCategory: subCategory,
      );
}

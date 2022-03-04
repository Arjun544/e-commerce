import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../models/category_model.dart';
import '../models/product_Model.dart';
import '../utils/constants.dart';

class ApiProduct {
  Future getCategories({
    required StreamController categoriesController,
  }) async {
    try {
      var categoriesResponse = await dio.get(
        baseUrl + 'categories/get',
        options: Options(
          responseType: ResponseType.plain,
        ),
      );
      categoriesController.add(categoryModelFromJson(categoriesResponse.data));
    } catch (e) {
      await EasyLoading.showToast(
        'Something went wrong',
        toastPosition: EasyLoadingToastPosition.top,
        maskType: EasyLoadingMaskType.clear,
      );
      print(e);
    }
  }

  Future getNewArrivalProducts({
    required int page,
    required StreamController arrivalController,
  }) async {
    try {
      var arrivalResponse = await dio.get(
        baseUrl + 'products/newArrival?page=$page&limit=10',
        options: Options(
          responseType: ResponseType.plain,
        ),
      );
      arrivalController.add(productModelFromJson(arrivalResponse.data));
    } catch (e) {
      await EasyLoading.showToast(
        'Something went wrong',
        toastPosition: EasyLoadingToastPosition.top,
        maskType: EasyLoadingMaskType.clear,
      );
      print(e);
    }
  }

  Future getFeaturedProducts({
    required int page,
    required StreamController featuredController,
  }) async {
    try {
      var featuredResponse = await dio.get(
        baseUrl + 'products/featured?page=$page&limit=10',
        options: Options(
          responseType: ResponseType.plain,
        ),
      );
      featuredController.add(productModelFromJson(featuredResponse.data));
    } catch (e) {
      await EasyLoading.showToast(
        'Something went wrong',
        toastPosition: EasyLoadingToastPosition.top,
        maskType: EasyLoadingMaskType.clear,
      );
      print(e);
    }
  }

  Future getSimilarProducts({
    required int page,
    required String categoryId,
    required String productId,
    required StreamController controller,
  }) async {
    try {
      var response = await dio.get(
        baseUrl + 'products/similar/$categoryId/$productId?page=$page&limit=10',
        options: Options(
          responseType: ResponseType.plain,
        ),
      );
      controller.add(productModelFromJson(response.data));
    } catch (e) {
      await EasyLoading.showToast(
        'Something went wrong',
        toastPosition: EasyLoadingToastPosition.top,
        maskType: EasyLoadingMaskType.clear,
      );
      print(e);
    }
  }

  Future getFilteredProducts({
    required String categoryId,
    String? subCategory,
    required StreamController controller,
    required bool hasQueryParam,
  }) async {
    try {
      if (hasQueryParam) {
        var response = await dio.get(
          baseUrl + 'products/byCategory/$categoryId?subCategory=$subCategory',
          options: Options(
            responseType: ResponseType.plain,
          ),
        );
        controller.add(productModelFromJson(response.data));
      } else {
        var response = await dio.get(
          baseUrl + 'products/byCategory/$categoryId',
          options: Options(
            responseType: ResponseType.plain,
          ),
        );
        controller.add(productModelFromJson(response.data));
      }
    } catch (e) {
      await EasyLoading.showToast(
        'Something went wrong',
        toastPosition: EasyLoadingToastPosition.top,
        maskType: EasyLoadingMaskType.clear,
      );
      print(e);
    }
  }

  Future searchProduct({
    required String query,
    required int page,
    required StreamController searchController,
  }) async {
    await EasyLoading.show(status: 'loading...', dismissOnTap: false);

    try {
    var response = await dio.get(
      baseUrl + 'products/search/$query?page=$page&limit=5',
      options: Options(
        responseType: ResponseType.plain,
      ),
    );
    searchController.add(productModelFromJson(response.data));
    await EasyLoading.dismiss();
    } catch (e) {
      await EasyLoading.showToast(
        'Something went wrong',
        toastPosition: EasyLoadingToastPosition.top,
        maskType: EasyLoadingMaskType.clear,
      );
      print(e);
    }
  }
}

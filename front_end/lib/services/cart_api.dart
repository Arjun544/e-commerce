import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:front_end/models/product_Model.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';
import '../utils/constants.dart';

class ApiCart {
  Future addToCart({
    required Product product,
    required String userId,
  }) async {
    await EasyLoading.show(status: 'loading...', dismissOnTap: false);

    try {
      await dio.post(baseUrl + 'cart/addToCart',
          data: {
            'product': product,
            'user': userId,
          },
          options: Options(headers: {
            'Authorization': 'Bearer ${getStorage.read('token')}'
          }));

      await EasyLoading.dismiss();
      await EasyLoading.showToast(
        'Added to cart',
        toastPosition: EasyLoadingToastPosition.top,
        maskType: EasyLoadingMaskType.clear,
      );
    } catch (e) {
      Get.snackbar('Something is wrong', e.toString(),
          snackPosition: SnackPosition.TOP);
      print(e);
    }
  }

  Future<CartModel> getCart({
    required String userId,
  }) async {
    try {
      var response = await dio.get(
        baseUrl + 'cart/getCart/$userId',
        options: Options(
            responseType: ResponseType.plain,
            headers: {'Authorization': 'Bearer ${getStorage.read('token')}'}),
      );

      return cartModelFromJson(response.data);
    } catch (e) {
      Get.snackbar('Something is wrong', e.toString(),
          snackPosition: SnackPosition.TOP);
      print(e);
      throw Exception('Failed to load');
    }
  }

  Future updateQuantity({
    required String productId,
    required String userId,
    required int value,
  }) async {
    try {
      await dio.patch(
        baseUrl + 'cart/updateQuantity/$userId',
        data: {
          'productId': productId,
          'value': value,
        },
        options: Options(
          responseType: ResponseType.plain,
          headers: {'Authorization': 'Bearer ${getStorage.read('token')}'},
        ),
      );
    } catch (e) {
      Get.snackbar('Something is wrong', e.toString(),
          snackPosition: SnackPosition.TOP);
      print(e);
    }
  }

  Future removeItemFromCart({
    required String id,
    required String productId,
  }) async {
    try {
      var response = await dio.delete(
        baseUrl + 'cart/$id',
        data: {
          'productId': productId,
        },
        options: Options(
          responseType: ResponseType.plain,
          headers: {'Authorization': 'Bearer ${getStorage.read('token')}'},
        ),
      );

      await EasyLoading.showToast(
        response.data,
        toastPosition: EasyLoadingToastPosition.top,
        maskType: EasyLoadingMaskType.clear,
      );
    } catch (e) {
      Get.snackbar('Something is wrong', e.toString(),
          snackPosition: SnackPosition.TOP);
      print(e);
    }
  }

  Future clearCart({
    required String userId,
  }) async {
    await EasyLoading.show(status: 'Clearing...', dismissOnTap: false);
    try {
      var response = await dio.delete(baseUrl + 'cart/clear/$userId');

      await EasyLoading.dismiss();
      await EasyLoading.showToast(
        response.data,
        toastPosition: EasyLoadingToastPosition.top,
        maskType: EasyLoadingMaskType.clear,
      );
    } catch (e) {
      Get.snackbar('Something is wrong', e.toString(),
          snackPosition: SnackPosition.TOP);
      print(e);
    }
  }
}

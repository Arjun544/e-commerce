import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';
import '../utils/constants.dart';

class ApiCart {
  Future addToCart({
    required String productId,
    required String userId,
  }) async {
    await EasyLoading.show(status: 'loading...', dismissOnTap: false);

    try {
      await dio.post(baseUrl + 'cart/addToCart', data: {
        'cartItem': [
          {
            'productId': productId,
          }
        ],
        'user': userId,
      });

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
    await EasyLoading.show(status: 'loading...', dismissOnTap: false);

    try {
      var response = await dio.get(
        baseUrl + 'cart/getCart/$userId',
        options: Options(
          responseType: ResponseType.plain,
        ),
      );
      await EasyLoading.dismiss();
      return cartModelFromJson(response.data);
    } catch (e) {
      Get.snackbar('Something is wrong', e.toString(),
          snackPosition: SnackPosition.TOP);
      print(e);
      throw Exception('Something is wrong');
    }
  }

  Future updateQuantity({
    required String productId,
    required String userId,
    required int newQuantity,
  }) async {
    try {
      var response =
          await dio.patch(baseUrl + 'cart/updateQuantity/$productId', data: {
        'userId': userId,
        'newQuantity': newQuantity,
      });
      await EasyLoading.showToast(
        response.data['message'],
        toastPosition: EasyLoadingToastPosition.top,
        maskType: EasyLoadingMaskType.clear,
      );
    } catch (e) {
      Get.snackbar('Something is wrong', e.toString(),
          snackPosition: SnackPosition.TOP);
      print(e);
    }
  }

  Future removeItemFromCart({
    required String id,
  }) async {
    try {
      var response = await dio.delete(baseUrl + 'cart/$id');

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
    try {
      var response = await dio.delete(baseUrl + 'cart/clear/$userId');

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

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:front_end/models/cart_model.dart';
import 'package:front_end/utils/constants.dart';
import 'package:get/get.dart';

class ApiCart {
  Future addToCart({
    required String productId,
    required String userId,
  }) async {
    await EasyLoading.show(status: 'loading...', dismissOnTap: false);

    try {
      await dio.post(baseUrl + 'cart/addToCart', data: {
        'product': productId,
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

  Future incrementQuantity({
    required String productId,
    required String userId,
  }) async {
    try {
      var response =
          await dio.patch(baseUrl + 'cart/incrementQuantity/$productId', data: {
        'userId': userId,
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

  Future decrementQuantity({
    required String productId,
    required String userId,
  }) async {
    try {
      var response =
          await dio.patch(baseUrl + 'cart/decrementQuantity/$productId', data: {
        'userId': userId,
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
}

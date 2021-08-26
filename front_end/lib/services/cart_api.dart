import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future getCart({
    required String userId,
    required StreamController controller,
  }) async {
    try {
      var response = await dio.get(
        baseUrl + 'cart/getCart/60f32dd949b3d700150f5899',
        options: Options(
          responseType: ResponseType.plain,
        ),
      );

      controller.add(cartModelFromJson(response.data));
    } catch (e) {
      Get.snackbar('Something is wrong', e.toString(),
          snackPosition: SnackPosition.TOP);
      print(e);
    }
  }

  Future updateQuantity({
    required String productId,
    required String userId,
    required int newQuantity,
  }) async {
    await EasyLoading.show(status: 'Updating...', dismissOnTap: false);
    try {
      var response =
          await dio.patch(baseUrl + 'cart/updateQuantity/$productId', data: {
        'userId': userId,
        'newQuantity': newQuantity,
      });
      await EasyLoading.dismiss();
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
    await EasyLoading.show(status: 'Removing...', dismissOnTap: false);
    try {
      var response = await dio.delete(baseUrl + 'cart/$id');
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

  Future clearCart({
    required String userId,
  }) async {
    await EasyLoading.show(status: 'Clearing...', dismissOnTap: false);
    try {
      var response = await dio.delete(baseUrl + 'cart/clear/$userId');
      await firebaseFirestore
          .collection('carts')
          .doc(getStorage.read('userId'))
          .delete();
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

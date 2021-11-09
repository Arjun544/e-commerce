import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../models/product_Model.dart';

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
      await EasyLoading.showToast(
        'Something went wrong',
        toastPosition: EasyLoadingToastPosition.top,
        maskType: EasyLoadingMaskType.clear,
      );
      print(e);
    }
  }

  Future<int> cartCount({
    required String userId,
  }) async {
    try {
      var response = await dio.get(
        baseUrl + 'cart/cartCount/$userId',
        options: Options(
          headers: {'Authorization': 'Bearer ${getStorage.read('token')}'},
        ),
      );
      return response.data;
    } catch (e) {
      await EasyLoading.showToast(
        'Something went wrong',
        toastPosition: EasyLoadingToastPosition.top,
        maskType: EasyLoadingMaskType.clear,
      );
      print(e);
      throw Exception('Failed to load');
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
      await EasyLoading.showToast(
        'Something went wrong',
        toastPosition: EasyLoadingToastPosition.top,
        maskType: EasyLoadingMaskType.clear,
      );
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
      await EasyLoading.showToast(
        'Something went wrong',
        toastPosition: EasyLoadingToastPosition.top,
        maskType: EasyLoadingMaskType.clear,
      );
      print(e);
    }
  }

  Future removeItemFromCart({
    required String id,
    required String productId,
  }) async {
    await EasyLoading.show(status: 'loading...', dismissOnTap: false);
    try {
      await dio.patch(
        baseUrl + 'cart/$id',
        data: {
          'productId': productId,
        },
        options: Options(
          responseType: ResponseType.plain,
          headers: {'Authorization': 'Bearer ${getStorage.read('token')}'},
        ),
      );
      await EasyLoading.dismiss();
      await EasyLoading.showToast(
        'Item deleted',
        toastPosition: EasyLoadingToastPosition.top,
        maskType: EasyLoadingMaskType.clear,
      );
    } catch (e) {
      await EasyLoading.showToast(
        'Something went wrong',
        toastPosition: EasyLoadingToastPosition.top,
        maskType: EasyLoadingMaskType.clear,
      );
      print(e);
    }
  }

  Future clearCart({
    required String userId,
  }) async {
    try {
       await dio.delete(
        baseUrl + 'cart/clear/$userId',
        options: Options(
          responseType: ResponseType.plain,
          headers: {'Authorization': 'Bearer ${getStorage.read('token')}'},
        ),
      );
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

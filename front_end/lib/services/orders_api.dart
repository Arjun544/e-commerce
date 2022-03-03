import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../models/cart_model.dart';
import '../models/trackOrder_model.dart';
import '../models/order_model.dart';
import '../models/userModel.dart';

import '../utils/constants.dart';

class ApiOrders {
  Future addOrder({
    required List<CartProduct> orderItems,
    required String shippingAddress,
    required String city,
    required String payment,
    required String deliveryType,
    required int deliveryFee,
    required String country,
    required String phone,
    required Data user,
  }) async {
    try {
      await dio.post(
        baseUrl + 'orders/add',
        data: {
          'orderItems': orderItems,
          'shippingAddress': shippingAddress,
          'city': city,
          'payment': payment,
          'deliveryType': deliveryType,
          'deliveryFee': deliveryFee,
          'country': country,
          'phone': phone,
          'status': 'Pending',
          'user': user,
        },
        options: Options(
            headers: {'Authorization': 'Bearer ${getStorage.read('token')}'}),
      );
    } catch (e) {
      await EasyLoading.showToast(
        'Something went wrong',
        toastPosition: EasyLoadingToastPosition.top,
        maskType: EasyLoadingMaskType.clear,
      );
      print(e);
      await EasyLoading.dismiss();
    }
  }

  Future<OrderModel> getUserOrders({
    required String userId,
  }) async {
    try {
      var response = await dio.get(
        baseUrl + 'orders/userOrders/$userId',
        options: Options(
          headers: {'Authorization': 'Bearer ${getStorage.read('token')}'},
        ),
      );

      return OrderModel.fromJson(response.data);
    } catch (e) {
      await EasyLoading.showToast(
        'Something went wrong',
        duration: const Duration(seconds: 2),
        toastPosition: EasyLoadingToastPosition.top,
        maskType: EasyLoadingMaskType.clear,
      );
      print(e);
      throw Exception('Failed to load');
    }
  }

  Future<void> updateStatus({
    required String orderId,
    required String status,
  }) async {
    try {
      await dio.patch(
        baseUrl + 'orders/$orderId',
        data: {
          'status': status,
        },
        options: Options(
          headers: {'Authorization': 'Bearer ${getStorage.read('token')}'},
        ),
      );
    } catch (e) {
      await EasyLoading.showToast(
        'Something went wrong',
        duration: const Duration(seconds: 2),
        toastPosition: EasyLoadingToastPosition.top,
        maskType: EasyLoadingMaskType.clear,
      );
      print(e);
    }
  }

  Future<TrackOrderModel> getOrderById({
    required String orderId,
  }) async {
    try {
      var response = await dio.get(
        baseUrl + 'orders/$orderId',
        options: Options(
          headers: {'Authorization': 'Bearer ${getStorage.read('token')}'},
        ),
      );
      return TrackOrderModel.fromJson(response.data);
    } catch (e) {
      await EasyLoading.showToast(
        'No order with this id',
        duration: const Duration(seconds: 4),
        toastPosition: EasyLoadingToastPosition.top,
        maskType: EasyLoadingMaskType.clear,
      );
      print(e);
      throw Exception('Failed to load');
    }
  }
}

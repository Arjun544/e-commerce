import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../utils/constants.dart';

class ApiOrders {
  Future addOrder({
    required List<Map<String, dynamic>> order,
    required String shippingAddress,
    required String city,
    required String payment,
    required String deliveryType,
    required int deliveryFee,
    required String country,
    required String phone,
    required String user,
  }) async {
    try {
      await dio.post(
        baseUrl + 'orders/add',
        data: {
          'orderItems': order,
          'shippingAddress': shippingAddress,
          'city': city,
          'payment': payment,
          'deliveryType': deliveryType,
          'deliveryFee': deliveryFee,
          'country': country,
          'phone': phone,
          'status': 'pending',
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
}

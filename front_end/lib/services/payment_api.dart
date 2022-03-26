import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../models/payment_card_model.dart';
import '../utils/constants.dart';

class ApiPayment {
  Future addCard({
    required String customerId,
    required String cardNumber,
    required String expMonth,
    required String expYear,
    required String cvc,
  }) async {
    await EasyLoading.show(status: 'Loading...', dismissOnTap: false);
    try {
      var response = await dio.post(
        baseUrl + 'payment/addCard',
        data: {
          'customerId': customerId,
          'card': {
            'number': cardNumber,
            'exp_year': expYear,
            'exp_month': expMonth,
            'cvc': cvc,
          }
        },
        options: Options(
          headers: {'Authorization': 'Bearer ${getStorage.read('token')}'},
          responseType: ResponseType.plain,
        ),
      );
      await EasyLoading.dismiss();
      return json.decode(response.data);
    } on DioError catch (e) {
      await EasyLoading.showToast(
        'Something went wrong',
        toastPosition: EasyLoadingToastPosition.top,
        maskType: EasyLoadingMaskType.clear,
      );
      print(e);
      throw Exception('Failed to load');
    }
  }

  Future getCustomerCard({
    required String id,
    required StreamController controller,
  }) async {
    await EasyLoading.show(status: 'Loading...', dismissOnTap: false);

    try {
      var response = await dio.get(
        baseUrl + 'payment/getCustomerCards/$id',
        options: Options(
          headers: {'Authorization': 'Bearer ${getStorage.read('token')}'},
          responseType: ResponseType.plain,
        ),
      );

      controller.add(paymentModelFromJson(response.data));

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

  Future deleteCard({
    required String id,
  }) async {
    await EasyLoading.show(status: 'Loading...', dismissOnTap: false);

    try {
      var response = await dio.post(
        baseUrl + 'payment/deleteCard/$id',
        options: Options(
          headers: {'Authorization': 'Bearer ${getStorage.read('token')}'},
          responseType: ResponseType.plain,
        ),
      );

      await EasyLoading.dismiss();
      await EasyLoading.showToast(
        response.data,
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

  Future payAmount({
    required int amount,
    required String customer,
    required String card,
    required String customerName,
    required String address,
    required String city,
    required String country,
  }) async {
    try {
      await dio.post(
        baseUrl + 'payment/pay',
        data: {
          'amount': amount,
          'customer': customer,
          'card': card,
          'customerName': customerName,
          'address': address,
          'city': city,
          'country': country,
        },
        options: Options(
          headers: {'Authorization': 'Bearer ${getStorage.read('token')}'},
          responseType: ResponseType.plain,
        ),
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

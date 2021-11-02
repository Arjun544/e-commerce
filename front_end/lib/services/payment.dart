import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../models/customer_model.dart';
import '../models/payment_card_model.dart';
import '../utils/constants.dart';
import 'package:get/get.dart';

class ApiPayment {
  Future addPaymentMethod({
    required String customerId,
    required String cardNumber,
    required String expMonth,
    required String expYear,
    required String cvc,
  }) async {
    await EasyLoading.show(status: 'Loading...', dismissOnTap: false);

    var response = await dio.post(
      baseUrl + 'payment/addPaymentMethods',
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
    if (response.statusCode == 200) {
      var data = customerModelFromJson(response.data);
      await getStorage.write('customerId', data.card.data[0].customer);
      await EasyLoading.dismiss();
    } else {
      await EasyLoading.showToast(
        'Something went wrong',
        toastPosition: EasyLoadingToastPosition.top,
        maskType: EasyLoadingMaskType.clear,
      );
      await EasyLoading.dismiss();
      throw Exception('failed to load');
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

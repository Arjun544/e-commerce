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
  Future<CustomerModel> createCustomer({
    required String name,
    required String cardNumber,
    required String expMonth,
    required String expYear,
    required String cvc,
  }) async {
    await EasyLoading.show(status: 'Loading...', dismissOnTap: false);

    var response = await dio.post(
      baseUrl + 'payment/createCustomer',
      data: {
        'name': name,
        'card': {
          'number': cardNumber,
          'exp_year': expYear,
          'exp_month': expMonth,
          'cvc': cvc,
        }
      },
      options: Options(
        responseType: ResponseType.plain,
      ),
    );
    if (response.statusCode == 200) {
      await EasyLoading.dismiss();
      log(response.data.toString());
      return customerModelFromJson(response.data);
    } else {
      throw Exception('failed to load');
    }
  }

  Future getCustomerCard({
    required String id,
    required String card,
    required StreamController controller,
  }) async {
    await EasyLoading.show(status: 'Loading...', dismissOnTap: false);

    try {
      var response = await dio.get(
        baseUrl + 'payment/getCustomerCard/$id/$card',
        options: Options(
          responseType: ResponseType.plain,
        ),
      );

      controller.add(paymentCardModelFromJson(response.data));

      await EasyLoading.dismiss();
    } catch (e) {
      Get.snackbar('Something is wrong', e.toString(),
          snackPosition: SnackPosition.TOP);
      print(e);
    }
  }
}

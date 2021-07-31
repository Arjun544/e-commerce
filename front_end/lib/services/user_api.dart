import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';

class ApiUser {
  Future updateProfile({
    required String userId,
    required String name,
    required String apartment,
    required String street,
    required int zipCode,
    required String country,
  }) async {
    await EasyLoading.show(status: 'loading...', dismissOnTap: false);

    try {
      await dio.post(
        baseUrl + 'users/update/$userId',
        data: {
          'name': name,
          'apartment': apartment,
          'street': street,
          'zip': zipCode,
          'country': country,
        },
        options: Options(
          responseType: ResponseType.plain,
        ),
      );

      await EasyLoading.showToast(
        'Profile updated',
        toastPosition: EasyLoadingToastPosition.top,
        maskType: EasyLoadingMaskType.clear,
      );

      await EasyLoading.dismiss();
    } catch (e) {
      Get.snackbar('Something is wrong', e.toString(),
          snackPosition: SnackPosition.TOP);
      print(e);
    }
  }
}

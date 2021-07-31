import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';

class ApiUser {
  Future updateProfile({
    required String userId,
    required String name,
    required String city,
    required String street,
    required int zipCode,
    required String country,
  }) async {
    await EasyLoading.show(status: 'loading...', dismissOnTap: false);

    try {
      await dio.patch(
        baseUrl + 'users/update/$userId',
        data: {
          'name': name,
          'city': city,
          'street': street,
          'zip': zipCode,
          'country': country,
        },
        options: Options(
          responseType: ResponseType.plain,
        ),
      );

      await EasyLoading.dismiss();
      await EasyLoading.showToast(
        'Profile updated',
        toastPosition: EasyLoadingToastPosition.top,
        maskType: EasyLoadingMaskType.clear,
      );
    } catch (e) {
      Get.snackbar('Something is wrong', e.toString(),
          snackPosition: SnackPosition.TOP);
      print(e);
    }
  }


  Future updateImage({
    required String userId,
    required String image,
  }) async {
    await EasyLoading.show(status: 'loading...', dismissOnTap: false);

    try {
      await dio.patch(
        baseUrl + 'users/update/$userId',
        data: {
          'profile': image,
        },
        options: Options(
          responseType: ResponseType.plain,
        ),
      );

      await EasyLoading.dismiss();
      await EasyLoading.showToast(
        'Profile updated',
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

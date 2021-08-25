import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../utils/constants.dart';
import 'package:get/get.dart';

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
      await dio.Dio().patch(
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
    required File image,
  }) async {
    await EasyLoading.show(status: 'loading...', dismissOnTap: false);
    String fileName = image.path.split('/').last;

    try {
      dio.FormData formData = dio.FormData.fromMap({
        'image':
            await dio.MultipartFile.fromFile(image.path, filename: fileName),
      });
      await dio.Dio().patch(
        baseUrl + 'users/updateImage/$userId',
        data: formData,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
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

  Future forgetPassword({
    required String email,
  }) async {
    await EasyLoading.show(status: 'loading...', dismissOnTap: false);

    try {
      var response = await dio.Dio().patch(
        baseUrl + 'users/forgotPassword',
        data: {
          'email': email,
        },
      );
      if (response.data['error'] == true) {
        // ignore: unawaited_futures
        EasyLoading.showToast(
          response.data['message'],
          toastPosition: EasyLoadingToastPosition.top,
          maskType: EasyLoadingMaskType.clear,
        );
      }
      await EasyLoading.dismiss();
      await EasyLoading.showToast(
        response.data['message'].toString(),
        toastPosition: EasyLoadingToastPosition.top,
        maskType: EasyLoadingMaskType.clear,
      );
    } catch (e) {
      Get.snackbar('Something is wrong', e.toString(),
          snackPosition: SnackPosition.TOP);
      print(e);
    }
  }

  Future passwordReset({
    required String code,
    required String newPassword,
    required String confirmPassword,
  }) async {
    await EasyLoading.show(status: 'loading...', dismissOnTap: false);

    try {
      dio.Response response = await dio.Dio().patch(
        baseUrl + 'users/resetPassword',
        data: {
          'token': code,
          'newPassword': newPassword,
          'confirmPassword': confirmPassword,
        },
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.data['error'] == true) {
        // ignore: unawaited_futures
        EasyLoading.showToast(
          response.data['message'].toString(),
          toastPosition: EasyLoadingToastPosition.top,
          maskType: EasyLoadingMaskType.clear,
        );
      }
      await EasyLoading.dismiss();
      await EasyLoading.showToast(
        response.data['message'].toString(),
        toastPosition: EasyLoadingToastPosition.top,
        maskType: EasyLoadingMaskType.clear,
      );
    } catch (e) {
      Get.snackbar('Something is wrong', e.toString(),
          snackPosition: SnackPosition.TOP);
      print(e);
    }
  }

  Future addAddress({
    required String userId,
    required String address,
    required String city,
    required String country,
    required String phone,
    required String type,
  }) async {
    await EasyLoading.show(status: 'loading...', dismissOnTap: false);

    try {
      await dio.Dio().patch(
        baseUrl + 'users/addAddress/$userId',
        data: {
          'address': address,
          'city': city,
          'country': country,
          'phone': phone,
          'type': type,
        },
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      await EasyLoading.dismiss();
      await EasyLoading.showToast(
        'Address has been added',
        toastPosition: EasyLoadingToastPosition.top,
        maskType: EasyLoadingMaskType.clear,
      );
    } catch (e) {
      Get.snackbar('Something is wrong', e.toString(),
          snackPosition: SnackPosition.TOP);
      print(e);
    }
  }

  Future removeAddress({
    required String userId,
    required String address,
    required String city,
    required String country,
    required String phone,
    required String type,
  }) async {
    await EasyLoading.show(status: 'loading...', dismissOnTap: false);

    try {
      await dio.Dio().patch(
        baseUrl + 'users/removeAddress/$userId',
        data: {
          'address': address,
          'city': city,
          'country': country,
          'phone': phone,
          'type': type,
        },
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      await EasyLoading.dismiss();
      await EasyLoading.showToast(
        'Address has been added',
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

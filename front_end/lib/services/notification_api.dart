import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../models/notification_model.dart';
import '../utils/constants.dart';

class NotificationApi {
  Future addToken({required String token, required String id}) async {
    try {
      await dio.patch(
        baseUrl + 'notification/addToken?token=$token',
        data: {
          'id': id,
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
      throw Exception('Failed to load');
    }
  }

  Future deleteToken({required String token, required String id}) async {
    try {
      await dio.patch(
        baseUrl + 'notification/deleteToken?token=$token',
        data: {
          'id': id,
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
      throw Exception('Failed to load');
    }
  }

  Future getNotifications(
      {required StreamController notificationController,
      required String userId}) async {
    await EasyLoading.show(status: 'Loading...', dismissOnTap: false);

    try {
      var response = await dio.get(
        baseUrl + 'notification/get/$userId',
        options: Options(
            responseType: ResponseType.plain,
            headers: {'Authorization': 'Bearer ${getStorage.read('token')}'}),
      );

      notificationController.add(notificationModelFromJson(response.data));

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

  Future updateHasRead({required String id}) async {
    await EasyLoading.show(status: 'Loading...', dismissOnTap: false);

    try {
      await dio.patch(
        baseUrl + 'notification/updateHasRead/$id',
        options: Options(
            responseType: ResponseType.plain,
            headers: {'Authorization': 'Bearer ${getStorage.read('token')}'}),
      );

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

  Future deleteNotification({required String id}) async {
    await EasyLoading.show(status: 'Loading...', dismissOnTap: false);

    try {
      await dio.delete(
        baseUrl + 'notification/delete/$id',
        options: Options(
            responseType: ResponseType.plain,
            headers: {'Authorization': 'Bearer ${getStorage.read('token')}'}),
      );

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

  Future markAllAsRead({required List<String> ids, required String userId}) async {
    await EasyLoading.show(status: 'Loading...', dismissOnTap: false);

    try {
      await dio.patch(
        baseUrl + 'notification/markAllAsRead/$userId?ids=$ids',
        options: Options(
            responseType: ResponseType.plain,
            headers: {'Authorization': 'Bearer ${getStorage.read('token')}'}),
      );

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

  Future clearAll({required String userId}) async {
    await EasyLoading.show(status: 'Loading...', dismissOnTap: false);

    try {
      await dio.delete(
        baseUrl + 'notification/clear/$userId',
        options: Options(
            responseType: ResponseType.plain,
            headers: {'Authorization': 'Bearer ${getStorage.read('token')}'}),
      );

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
}

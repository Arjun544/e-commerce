import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../utils/constants.dart';

class NotificationApi {
  Future sendNotification({required List<String> tokens, required String title, required String body}) async {
    try {
      await dio.post(
        baseUrl + 'notification/send',
        data: {
          'deviceToken': tokens,
          'title': title,
          'body': body,
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
}

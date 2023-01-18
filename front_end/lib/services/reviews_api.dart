import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../utils/constants.dart';

class ApiReviews {
  Future addReviews({
    required String userId,
    required String orderId,
    required String productId,
    required String review,
    required double rating,
  }) async {
    try {
      await dio.post(
        baseUrl + 'reviews/add/$orderId',
        data: {
          'userId': userId,
          'productId': productId,
          'review': review,
          'rating': rating,
        },
        options: Options(
          responseType: ResponseType.plain,
          headers: {'Authorization': 'Bearer ${getStorage.read('token')}'},
        ),
      );
    } catch (e) {
      await EasyLoading.dismiss();
      await EasyLoading.showToast(
        'Something went wrong',
        toastPosition: EasyLoadingToastPosition.top,
        maskType: EasyLoadingMaskType.clear,
      );
      print(e);
    }
  }

  Future skipReview({
    required String id,
    required String productId,
  }) async {
    try {
      await dio.patch(
        baseUrl + 'reviews/skip/$id',
        data: {
          'productId': productId,
        },
        options: Options(
          responseType: ResponseType.plain,
          headers: {'Authorization': 'Bearer ${getStorage.read('token')}'},
        ),
      );
    } catch (e) {
      await EasyLoading.dismiss();
      await EasyLoading.showToast(
        'Something went wrong',
        toastPosition: EasyLoadingToastPosition.top,
        maskType: EasyLoadingMaskType.clear,
      );
      print(e);
    }
  }
}

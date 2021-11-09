import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../models/product_Model.dart';
import '../utils/constants.dart';

class ApiWishList {
  Future getWishlist({
    required List<String> ids,
    required StreamController wishlistController,
  }) async {
    await EasyLoading.show(status: 'Loading...', dismissOnTap: false);

    try {
      var response = await dio.post(
        baseUrl + 'users/wishlist',
        data: {'ids': ids},
        options: Options(
          responseType: ResponseType.plain,
        ),
      );

      wishlistController.add(productModelFromJson(response.data));

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

  Future clearWishlist({
    required String userId,
  }) async {
    await EasyLoading.show(status: 'Clearing...', dismissOnTap: false);

    try {
      var response = await dio.patch(
        baseUrl + 'users/wishlist/$userId',
        options: Options(
          responseType: ResponseType.plain,
        ),
      );
      await EasyLoading.showToast(
        response.data,
        toastPosition: EasyLoadingToastPosition.top,
        maskType: EasyLoadingMaskType.clear,
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

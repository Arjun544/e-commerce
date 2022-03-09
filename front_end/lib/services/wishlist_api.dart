import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../models/product_Model.dart';
import '../utils/constants.dart';

class ApiWishList {
  Future<List<Product>> getWishlist({
    required List<String> ids,
    required StreamController wishlistController,
  }) async {
    await EasyLoading.show(status: 'Loading...', dismissOnTap: false);

    // try {
    var response = await dio.post(
      baseUrl + 'users/wishlist',
      data: {'ids': ids},
      options: Options(
        responseType: ResponseType.plain,
      ),
    );

    await EasyLoading.dismiss();
    return response.data
        .map<Product>((json) => Product.fromJson(json))
        .toList();

    // } catch (e) {
    //   await EasyLoading.showToast(
    //     'Something went wrong',
    //     toastPosition: EasyLoadingToastPosition.top,
    //     maskType: EasyLoadingMaskType.clear,
    //   );
    //   print(e);
    // }
  }
}

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../models/product_Model.dart';
import '../utils/constants.dart';
import 'package:get/get.dart';

class ApiProduct {
  Future getData({
    required StreamController arrivalController,
    required StreamController featuredController,
  }) async {
    await EasyLoading.show(status: 'loading...', dismissOnTap: false);

    try {
      var arrivalResponse = await dio.get(
        baseUrl + 'products/newArrival',
        options: Options(
          responseType: ResponseType.plain,
        ),
      );
      var featuredResponse = await dio.get(
        baseUrl + 'products/featured',
        options: Options(
          responseType: ResponseType.plain,
        ),
      );

      arrivalController.add(productModelFromJson(arrivalResponse.data));

      featuredController.add(productModelFromJson(featuredResponse.data));
      await EasyLoading.dismiss();
    } catch (e) {
      Get.snackbar('Something is wrong', e.toString(),
          snackPosition: SnackPosition.TOP);
      print(e);
    }
  }
}

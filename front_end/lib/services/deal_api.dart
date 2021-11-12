import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../models/deal_model.dart';
import '../utils/constants.dart';

class DealApi {
  Future<DealModel> getDeal() async {
    try {
      var response = await dio.get(
        baseUrl + 'deal/getUserDeal',
        options: Options(
          responseType: ResponseType.plain,
        ),
      );

      return dealModelFromJson(response.data);
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

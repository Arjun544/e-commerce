import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../models/banner_model.dart';
import '../utils/constants.dart';

class BannersApi {
  Future<BannerModel> getBanners() async {
    try {
      var response = await dio.get(
        baseUrl + 'banners/getUserBanners',
        options: Options(
          responseType: ResponseType.plain,
        ),
      );
      return bannerModelFromJson(response.data);
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

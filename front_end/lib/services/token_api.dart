import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:front_end/utils/constants.dart';
import 'package:jwt_decode/jwt_decode.dart';

Future<bool> refreshToken() async {
  Response response = await dio.post(baseUrl + 'admin/refresh', data: {
    'refreshTokenFromCookie': getStorage.read('token'),
  });

  if (response.statusCode == 200) {
    log(response.data.toString());
    // secStore.secureWrite('token', token);
    // secStore.secureWrite('refresh', refresh);
    return true;
  } else {
    return false;
  }
}

bool isTokenExpired(String _token) {
  DateTime? expiryDate = Jwt.getExpiryDate(_token);
  bool isExpired = expiryDate!.compareTo(DateTime.now()) < 0;
  return isExpired;
}

// class AuthInterceptor extends Interceptor {
//   static bool isRetryCall = false;

//   @override
//   void onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     bool _token = isTokenExpired(token);
//     bool _refresh = isTokenExpired(refresh);
//     bool _refreshed = true;

//     if (_refresh) {
//       appAuth.logout();
//       EasyLoading.showInfo('Expired session');
//       DioError _err;
//       handler.reject(_err);
//     } else if (_token) {
//       _refreshed = await appAuth.refreshToken();
//     }
//     if (_refreshed) {
//       options.headers["Authorization"] = "Bearer " + token;
//       options.headers["Accept"] = "application/json";

//       handler.next(options);
//     }
//   }

//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) async {
//     handler.next(response);
//   }

//   @override
//   void onError(DioError err, ErrorInterceptorHandler handler) async {
//     handler.next(err);
//   }
// }

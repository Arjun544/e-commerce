import 'dart:developer';

import 'package:dio/dio.dart';

class ApiServices {
  Dio dio = Dio();

  final String baseUrl = 'https://sell-corner.herokuapp.com/api/';

  Future<void> signUp(String username, String email, String password,
      String confirmPassword) async {
    Map data = {
      'username': username,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
    };

    Response response = await dio.post(
      baseUrl + 'users/register',
      data: data,
    );
    print('response: ${response.data}');
  }
}

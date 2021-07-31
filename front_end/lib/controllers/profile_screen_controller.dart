import 'dart:io';

import 'package:front_end/utils/constants.dart';
import 'package:get/get.dart';

import '../services/user_api.dart';

class ProfileScreenController extends GetxController {
  RxInt currentAvatar = 0.obs;

  Future updateProfile(
          {required String userId,
          required String name,
          required String city,
          required String street,
          required int zipCode,
          required String country}) async =>
      await ApiUser().updateProfile(
          userId: userId,
          name: name,
          city: city,
          street: street,
          zipCode: zipCode,
          country: country);

  Future updateImage({required File imageUrl}) async => await ApiUser()
      .updateImage(userId: getStorage.read('userId'), image: imageUrl);

  List<String> avatars = [
    'assets/avatars/avatar 1.png',
    'assets/avatars/avatar 2.png',
    'assets/avatars/avatar 3.png',
    'assets/avatars/avatar 4.png',
    'assets/avatars/avatar 5.png',
    'assets/avatars/avatar 6.png',
    'assets/avatars/avatar 7.png',
    'assets/avatars/avatar 8.png',
    'assets/avatars/avatar 9.png',
  ];
}

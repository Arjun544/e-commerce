import 'dart:io';

import 'package:flutter/material.dart';
import 'root_screen_controller.dart';
import '../models/userModel.dart';

import '../utils/constants.dart';
import 'package:get/get.dart';

import '../services/user_api.dart';

class ProfileScreenController extends GetxController {
  final RootScreenController rootScreenController = Get.find();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  RxInt currentAvatar = 0.obs;
  RxInt selectedShippingAddress = 0.obs;
  RxInt currentPaymentCard = 0.obs;
  UserModel? currentUser;

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

  Future forgetPassowrd({required String email}) async =>
      await ApiUser().forgetPassword(email: email);

  Future resetPassword(
          {required String code,
          required String newPassword,
          required String confirmPassword}) async =>
      await ApiUser().passwordReset(
          code: code,
          newPassword: newPassword,
          confirmPassword: confirmPassword);

  Future addAddress({
    required String address,
    required String city,
    required String country,
    required String phone,
    required String type,
  }) async =>
      await ApiUser().addAddress(
          userId: getStorage.read('userId'),
          address: address,
          city: city,
          country: country,
          phone: phone,
          type: type);

  Future removeAddress({
    required String address,
    required String city,
    required String country,
    required String phone,
    required String type,
  }) async =>
      await ApiUser().removeAddress(
          userId: getStorage.read('userId'),
          address: address,
          city: city,
          country: country,
          phone: phone,
          type: type);

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

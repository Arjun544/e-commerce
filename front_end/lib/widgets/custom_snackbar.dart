import 'package:flutter/material.dart';
import 'package:front_end/utils/colors.dart';
import 'package:get/get.dart';

void customSnackBar(String msg) {
  return Get.snackbar(
    '',
    '',
    titleText: const Text(
      'Something is wrong',
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
    ),
    messageText: Text(
      msg,
      style: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
    ),
    backgroundColor: darkBlue.withOpacity(0.5),
    snackPosition: SnackPosition.TOP,
    margin: const EdgeInsets.only(top: 15, right: 15, left: 10, bottom: 20),
  );
}

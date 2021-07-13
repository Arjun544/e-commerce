import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {

  RxInt currentIndex = 0.obs;

  void updateIndex(int value) {
    currentIndex.value = value;
  }
}

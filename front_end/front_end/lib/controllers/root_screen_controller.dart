
import 'package:get/get.dart';

class RootScreenController extends GetxController{
  RxInt currentIndex = 0.obs;

  void updateIndex(int value) {
    currentIndex.value = value;
  }
}
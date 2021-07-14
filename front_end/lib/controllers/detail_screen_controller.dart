import 'package:get/get.dart';

class DetailScreenController extends GetxController {
  RxInt currentImage = 0.obs;
  RxBool isTileTappedOne = true.obs;
  RxBool isTileExpandedOne = false.obs;
  RxBool isTileTappedTwo = true.obs;
  RxBool isTileExpandedTwo = false.obs;

  void updateImage(int newImage) {
    currentImage.value = newImage;
  }

  void updateTileStatusOne() {
    isTileTappedOne.value = !isTileTappedOne.value;
  }

  void updateTileStatusTwo() {
    isTileTappedTwo.value = !isTileTappedTwo.value;
  }
}

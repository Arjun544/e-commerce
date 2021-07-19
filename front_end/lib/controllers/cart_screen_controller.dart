import 'package:hive/hive.dart';

import '../models/product_Model.dart';
import 'package:get/get.dart';

class CartScreenController extends GetxController {
  RxInt totalPrice = 0.obs;
  RxList<ProductModel> cartList = <ProductModel>[].obs;
  RxList<String> cartItemIds = <String>[].obs;
  var cartBox;

  @override
  void onReady() async {
    cartBox = await Hive.openBox('cartBox');
    super.onReady();
  }

  void calculateTotalPrice(int price) {
    totalPrice.value += price;
  }

  void updateTotalPrice(int price) {
    totalPrice.value -= price;
  }
}

import 'dart:async';

import '../models/cart_model.dart';
import '../models/product_Model.dart';

import '../utils/constants.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import '../services/cart_api.dart';

class CartScreenController extends GetxController {
  var cartProducts = <CartModel>[].obs;
  StreamController cartTotal = BehaviorSubject();
  RxList<CartProduct> orderItems = <CartProduct>[].obs;
  RxBool isOrderItemsSelected = false.obs;
  RxInt orderItemsTotal = 0.obs;

  void addToCart(Product product) async {
    await ApiCart().addToCart(
      product: product,
      userId: getStorage.read('userId'),
    );
  }

  void getCart() async {
    var products = await ApiCart().getCart(
      userId: getStorage.read('userId'),
    );
    if (products != null) {
      cartProducts.value.add(products);
    }
  }

  Future updateQuantity(
          {required String productId, required int value}) async =>
      await ApiCart().updateQuantity(
        productId: productId,
        value: value,
        userId: getStorage.read('userId'),
      );

  Future deleteItem({required String id, required String productId}) async =>
      await ApiCart().removeItemFromCart(id: id, productId: productId);

  Future clearCart({required String userId}) async => await ApiCart().clearCart(
        userId: userId,
      );
}

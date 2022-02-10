import 'dart:async';

import '../models/cart_model.dart';
import '../models/product_Model.dart';

import '../utils/constants.dart';
import 'package:get/get.dart';
import '../services/cart_api.dart';

class CartScreenController extends GetxController {
  var cartProducts = CartModel(
          products: [],
          id: '',
          user: '',
          dateOrdered: DateTime.now(),
          v: 0,
          cartModelId: '')
      .obs;
  RxInt cartTotal = 0.obs;
  RxList<CartProduct> orderItems = <CartProduct>[].obs;
  RxBool isOrderItemsSelected = false.obs;
  RxBool isLoading = false.obs;
  RxInt orderItemsTotal = 0.obs;

  void addToCart(Product product) async {
    await ApiCart().addToCart(
      product: product,
      userId: getStorage.read('userId'),
    );
  }

  Future getCart() async {
    isLoading.value = true;
    var products = await ApiCart().getCart(
      userId: getStorage.read('userId'),
    );
    cartProducts.value = products;
    isLoading.value = false;
  }

  Future updateQuantity(
          {required String productId, required int value}) async =>
      await ApiCart().updateQuantity(
        productId: productId,
        value: value,
        userId: getStorage.read('userId'),
      );

  Future deleteItem({
    required String id,
    required String productId,
  }) async =>
      await ApiCart().removeItemFromCart(id: id, productId: productId);

  Future clearCart() async => await ApiCart().clearCart(
        userId: getStorage.read('userId'),
      );
}

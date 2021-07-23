import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../models/cart_model.dart';
import '../services/cart_api.dart';

class CartScreenController extends GetxController {
  RxList<CartList> cartProducts = <CartList>[].obs;
   RxInt cartTotal = 0.obs;

  late Socket socket;
  RxString userId = '60f32dd949b3d700150f5899'.obs;

  void cartSocketInit() {
    socket = io(
        // 'http://192.168.0.100:3000',
        'https://sell-corner.herokuapp.com/',
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect()
            .enableForceNewConnection() // disable auto-connection
            .build());
    socket.connect();
    socket.onConnect((data) => print('sockeeeeeeeeet is connected'));

    print(socket.connected);
  }

  Future addToCart({required String productId, required String userId}) async =>
      await ApiCart().addToCart(
        productId: productId,
        userId: userId,
      );

  void getCart() async {
    var cart = await ApiCart().getCart(userId: userId.value);
    cartTotal.value = cart.totalGrand!;
    cartProducts.value = cart.cartList!;
    log(cartProducts.toString());
  }

  Future updateQuantity(
          {required String productId, required int newQuantity}) async =>
      await ApiCart().updateQuantity(
        productId: productId,
        userId: userId.value,
        newQuantity: newQuantity,
      );

  // Future decrementQuantity({required String productId}) async =>
  //     await ApiCart().decrementQuantity(
  //       productId: productId,
  //       userId: userId.value,
  //     );
}

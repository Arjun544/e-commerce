import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/constants.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../models/cart_model.dart';
import '../services/cart_api.dart';

class CartScreenController extends GetxController {
  RxList<CartList> cartProducts = <CartList>[].obs;
  StreamController cartTotal = BehaviorSubject();
  List<String> productIds = [];

  late Socket socket;
  RxString currentUserId = ''.obs;

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

  Future addToCart({required String productId}) async {
    List<String> productIds = [];
    productIds.insert(0, productId);
    await ApiCart().addToCart(
      productId: productId,
      userId: currentUserId.value,
    );
    await firebaseFirestore.collection('carts').doc(currentUserId.value).update({
      'productIds': FieldValue.arrayUnion([productId])
    });
  }

  void getCart() async {
    var cart = await ApiCart().getCart(userId: currentUserId.value);
    cartTotal.add(cart.totalGrand);
    cartProducts.value = cart.cartList!;
    log(cartProducts.toString());
  }

  Future updateQuantity(
          {required String productId, required int newQuantity}) async =>
      await ApiCart().updateQuantity(
        productId: productId,
        userId: currentUserId.value,
        newQuantity: newQuantity,
      );

  Future deleteItem({required String id}) async =>
      await ApiCart().removeItemFromCart(
        id: id,
      );

  Future clearCart({required String userId}) async => await ApiCart().clearCart(
        userId: userId,
      );
}

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/constants.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../models/cart_model.dart';
import '../services/cart_api.dart';

class CartScreenController extends GetxController {
  final StreamController<CartModel> cartProductsStreamController =
      BehaviorSubject();
  StreamController cartTotal = BehaviorSubject();
  RxDouble totalAfterDiscount = 0.0.obs;
  List<String> productIds = [];
  RxInt cartProductsLength = 0.obs;
  late Socket socket;

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
      userId: getStorage.read('userId'),
    );
    await firebaseFirestore
        .collection('carts')
        .doc(getStorage.read('userId'))
        .set({
      'productIds': FieldValue.arrayUnion([productId])
    });
  }

  void getCart() async {
    await ApiCart().getCart(
        userId: getStorage.read('userId'),
        controller: cartProductsStreamController);
  }

  Future updateQuantity(
          {required String productId, required int newQuantity}) async =>
      await ApiCart().updateQuantity(
        productId: productId,
        userId: getStorage.read('userId'),
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

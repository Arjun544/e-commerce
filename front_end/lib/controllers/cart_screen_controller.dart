import 'dart:async';
import 'dart:developer';

import 'package:front_end/models/cart_model.dart';
import 'package:front_end/services/cart_api.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:socket_io_client/socket_io_client.dart';

class CartScreenController extends GetxController {
  final StreamController<CartModel> cartStreamController = BehaviorSubject();
  final StreamController<int> incrementController = BehaviorSubject();
  final StreamController<int> decrementController = BehaviorSubject();
  late Socket socket;
  RxString userId = ''.obs;
  RxInt grandPrice = 0.obs;
  RxInt productQuantity = 0.obs;

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

  Future getCart({required String userId}) async => await ApiCart().getCart(
        userId: userId,
        cartController: cartStreamController,
      );

  Future incrementQuantity({required String productId}) async =>
      await ApiCart().incrementQuantity(
        productId: productId,
        userId: userId.value,
      );

  Future decrementQuantity({required String productId}) async =>
      await ApiCart().decrementQuantity(
        productId: productId,
        userId: userId.value,
      );
}

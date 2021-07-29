import 'dart:async';

import 'cart_screen_controller.dart';

import '../models/product_Model.dart';
import '../services/wishlist_api.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class WishListController extends GetxController {
  final CartScreenController cartScreenController = Get.find();
  final StreamController<ProductModel> wishlistController = BehaviorSubject();
  List<String> ids = [];

  Future getWishlist() async {
    await ApiWishList()
        .getWishlist(ids: ids, wishlistController: wishlistController);
  }

  Future clearWishlist() async {
    await ApiWishList()
        .clearWishlist(userId: cartScreenController.currentUserId.value);
  }
}

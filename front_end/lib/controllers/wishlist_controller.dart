import 'dart:async';

import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../models/product_Model.dart';
import '../services/wishlist_api.dart';
import '../utils/constants.dart';
import 'cart_screen_controller.dart';

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
        .clearWishlist(userId: getStorage.read('userId'));
  }
}

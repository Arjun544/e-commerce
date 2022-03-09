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
  List<String> wishlistIds = [];

  Future getWishlist() async {
    await ApiWishList()
        .getWishlist(ids: wishlistIds, wishlistController: wishlistController);
  }

  Future clearWishlist() async {
    await getStorage.remove('wishlistIds');
  }
}

import 'dart:async';

import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../models/product_Model.dart';
import '../services/wishlist_api.dart';
import '../utils/constants.dart';

class WishListController extends GetxController {
  final StreamController<ProductModel> wishlistController = BehaviorSubject();
  List<String> wishlistIds = [];

  void getWishlist() async {
    await ApiWishList()
        .getWishlist(ids: wishlistIds, wishlistController: wishlistController);
  }

  Future clearWishlist() async {
    await sharedPreferences.remove('wishlistIds');
  }
}

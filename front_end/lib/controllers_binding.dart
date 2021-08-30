import 'controllers/filtered_products_screen_controller.dart';
import 'controllers/profile_screen_controller.dart';
import 'package:get/get.dart';

import 'controllers/cart_screen_controller.dart';
import 'controllers/detail_screen_controller.dart';
import 'controllers/home_screen_controller.dart';
import 'controllers/register_screen_controller.dart';
import 'controllers/root_screen_controller.dart';
import 'controllers/wishlist_controller.dart';

class ControllersBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RootScreenController>(() => RootScreenController());
    Get.lazyPut<RegisterScreenController>(() => RegisterScreenController());
    Get.lazyPut<HomeScreenController>(() => HomeScreenController());
    Get.lazyPut<CartScreenController>(() => CartScreenController());
    Get.lazyPut<DetailScreenController>(() => DetailScreenController());
    Get.lazyPut<WishListController>(() => WishListController());
    Get.lazyPut<ProfileScreenController>(() => ProfileScreenController());
    Get.lazyPut<FilteredProductsScreenController>(() => FilteredProductsScreenController());
  }
}

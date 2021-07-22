import 'controllers/cart_screen_controller.dart';
import 'controllers/home_screen_controller.dart';
import 'controllers/register_screen_controller.dart';
import 'controllers/root_screen_controller.dart';
import 'package:get/get.dart';

class ControllersBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RootScreenController>(() => RootScreenController());
    Get.lazyPut<RegisterScreenController>(() => RegisterScreenController());
    Get.lazyPut<HomeScreenController>(() => HomeScreenController());
    Get.lazyPut<CartScreenController>(() => CartScreenController());
  }
}

import 'package:get/get.dart';

class CartScreenController extends GetxController {
  final StreamController<ProductModel> featuredProductsStreamController =
      rxDart.BehaviorSubject();
}

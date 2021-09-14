
import 'package:get/get.dart';

class CheckoutScreenController extends GetxController {
  RxInt activeStep = 0.obs;
  int subTotal = 0;
  RxInt selectedDelivery = 0.obs;
  RxInt selectedPayment = 0.obs;
  List<int> orderItemsPrices = [];
}

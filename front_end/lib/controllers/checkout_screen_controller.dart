
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'cart_screen_controller.dart';
import 'root_screen_controller.dart';
import '../models/delivery_model.dart';
import '../models/userModel.dart';
import '../screens/checkout_screen/components/pay_success_dialogue.dart';
import '../services/orders_api.dart';
import '../services/payment_api.dart';
import 'package:get/get.dart';

class CheckoutScreenController extends GetxController {
  final CartScreenController cartScreenController = Get.find();
  final RootScreenController rootScreenController = Get.find();
  RxInt activeStep = 0.obs;
  int subTotal = 0;
  RxInt selectedDelivery = 0.obs;
  RxInt selectedPayment = 0.obs;
  List<int> orderItemsPrices = [];
  RxInt currentCard = 0.obs;

  Map<String, dynamic> order = {};

  void orderPay(BuildContext context) async {
    await EasyLoading.show(status: 'Paying...', dismissOnTap: false);
    UserModel? currentUser = await rootScreenController.getCurrentUser();
    await ApiOrders().addOrder(
      order: cartScreenController.orderItems
          .map((element) =>
              {'quantity': element.quantity, 'product': element.id})
          .toList(),
      shippingAddress: order['shippingAddress'],
      city: order['city'],
      payment: order['payment'] == 0 ? 'Cash' : 'Card',
      deliveryType: order['delivery'] == 0 ? 'Free' : 'Express',
      deliveryFee: order['deliveryFees'],
      country: order['country'],
      phone: order['phone'],
      user: currentUser!.data.id,
    );
    if (order['payment'] == 1) {
      await ApiPayment().payAmount(
        amount: subTotal + deliveryOptions[selectedDelivery.value].price,
        customer: currentUser.data.customerId,
        card: order['card'],
        customerName: currentUser.data.username,
        address: order['shippingAddress'],
        city: order['city'],
        country: order['country'],
      );
    }
    await EasyLoading.dismiss();
    PaySuccessDialogue(context);
  }
}

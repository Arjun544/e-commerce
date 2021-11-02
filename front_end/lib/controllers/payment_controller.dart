import 'dart:async';
import 'dart:developer';

import 'package:front_end/controllers/root_screen_controller.dart';
import 'package:front_end/models/userModel.dart';

import '../models/payment_card_model.dart';
import '../services/payment.dart';
import '../utils/constants.dart';

import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class PaymentController extends GetxController {
  final RootScreenController rootScreenController = Get.find();
  final StreamController<PaymentModel> paymentCardStreamController =
      BehaviorSubject();

  Future addPaymentMethod({
    required String customerId,
    required String cardNumber,
    required String expMonth,
    required String expYear,
    required String cvc,
  }) async {
    await ApiPayment().addPaymentMethod(
      customerId: customerId,
      cardNumber: cardNumber,
      expMonth: expMonth,
      expYear: expYear,
      cvc: cvc,
    );
  }

  Future getCustomerCard() async {
    UserModel? userModel = await rootScreenController.getCurrentUser();
    log(userModel.toString());
    await ApiPayment().getCustomerCard(
        id: userModel!.data.customerId,
        controller: paymentCardStreamController);
  }
}

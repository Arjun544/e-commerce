import 'dart:async';

import 'root_screen_controller.dart';
import '../models/userModel.dart';

import '../models/payment_card_model.dart';
import '../services/payment_api.dart';

import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class PaymentController extends GetxController {
  final RootScreenController rootScreenController = Get.find();
  final StreamController<PaymentModel> paymentCardStreamController =
      BehaviorSubject();

  Future addCard({
    required String customerId,
    required String cardNumber,
    required String expMonth,
    required String expYear,
    required String cvc,
  }) async =>
      await ApiPayment().addCard(
        customerId: customerId,
        cardNumber: cardNumber,
        expMonth: expMonth,
        expYear: expYear,
        cvc: cvc,
      );

  Future getCustomerCard() async {
    UserModel? userModel = await rootScreenController.getCurrentUser();
    await ApiPayment().getCustomerCard(
        id: userModel!.data.customerId,
        controller: paymentCardStreamController);
  }

  Future deleteCard({required String id}) async {
    await ApiPayment().deleteCard(
      id: id,
    );
  }
}

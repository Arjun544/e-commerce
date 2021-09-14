import 'dart:async';

import 'package:front_end/models/payment_card_model.dart';
import 'package:front_end/services/payment.dart';
import 'package:front_end/utils/constants.dart';

import '../models/customer_model.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class PaymentController extends GetxController {
  final StreamController<PaymentCardModel> paymentCardStreamController =
      BehaviorSubject();

  Future createCustomer({
    required String name,
    required String cardNumber,
    required String expMonth,
    required String expYear,
    required String cvc,
  }) async {
    await ApiPayment().createCustomer(
      name: name,
      cardNumber: cardNumber,
      expMonth: expMonth,
      expYear: expYear,
      cvc: cvc,
    );
  }

  Future getCustomerCard({
    required String id,
    required String card,
  }) async =>
      await ApiPayment().getCustomerCard(
          id: id, card: card, controller: paymentCardStreamController);
}

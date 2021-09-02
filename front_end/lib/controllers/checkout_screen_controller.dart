import 'package:flutter/material.dart';
import '../screens/checkout_screen/components/step_four.dart';
import '../screens/checkout_screen/components/step_one.dart';
import '../screens/checkout_screen/components/step_three.dart';
import '../screens/checkout_screen/components/step_two.dart';

import '../models/cart_model.dart';
import 'package:get/get.dart';

class CheckoutScreenController extends GetxController {
  RxInt activeStep = 0.obs;
  int subTotal = 0;
  RxInt selectedDelivery = 0.obs;
  List<int> orderItemsPrices = [];
  RxList<CartItem> orderItems = <CartItem>[].obs;

  List<Widget> activeStepView = [
    StepOne(),
    StepTwo(),
    StepThree(),
    StepFour(),
  ];
}

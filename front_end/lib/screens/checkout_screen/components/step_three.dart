import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:front_end/controllers/checkout_screen_controller.dart';
import 'package:front_end/controllers/payment_controller.dart';
import 'package:front_end/models/payment_card_model.dart';
import 'package:front_end/utils/colors.dart';
import 'package:front_end/widgets/credit_card_widget.dart';
import 'package:front_end/widgets/custom_button.dart';
import 'package:get/get.dart';

class StepThree extends StatefulWidget {
  @override
  _StepThreeState createState() => _StepThreeState();
}

class _StepThreeState extends State<StepThree> {
  final CheckoutScreenController checkoutScreenController = Get.find();

  final PaymentController paymentController = Get.put(PaymentController());

  void onCardContinuePressed(Datum card) {
    checkoutScreenController.activeStep.value += 1;
    checkoutScreenController.order['payment'] =
        checkoutScreenController.selectedPayment.value;
    checkoutScreenController.order['card'] = card.id;
    log(checkoutScreenController.order.toString());
  }

  void onContinuePressed() {
    checkoutScreenController.activeStep.value += 1;
    checkoutScreenController.order['payment'] =
        checkoutScreenController.selectedPayment.value;
    log(checkoutScreenController.order.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: 2,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              itemBuilder: (context, index) {
                return Container(
                  height: 60,
                  width: Get.width * 0.8,
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: customGrey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Radio(
                        activeColor: customYellow,
                        toggleable: true,
                        value: index == 0 ? 0 : 1,
                        groupValue:
                            checkoutScreenController.selectedPayment.value,
                        onChanged: (value) async {
                          checkoutScreenController.selectedPayment.value =
                              index;
                          if (index == 1) {
                            await paymentController.getCustomerCard();
                          }
                        },
                      ),
                      index == 0
                          ? const Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Text(
                                'Cash On Delivery',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            )
                          : Image.asset(
                              'assets/Stripe.png',
                              fit: BoxFit.cover,
                              width: Get.width * 0.2,
                            ),
                    ],
                  ),
                );
              }),
          checkoutScreenController.selectedPayment.value == 1
              ? StreamBuilder(
                  stream: paymentController.paymentCardStreamController.stream,
                  builder: (context, AsyncSnapshot<PaymentModel> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox.shrink();
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 15, bottom: 10),
                          child: Text(
                            'Select card to pay',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          width: Get.width,
                          height: 200,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.card.data.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Obx(
                                      () => Radio(
                                        activeColor: customYellow,
                                        toggleable: true,
                                        value: index == 0 ? 0 : 1,
                                        groupValue: checkoutScreenController
                                            .currentCard.value,
                                        onChanged: (value) async {
                                          checkoutScreenController
                                              .currentCard.value = index;

                                          checkoutScreenController
                                                  .order['card'] =
                                              snapshot
                                                  .data!.card.data[index].id;
                                        },
                                      ),
                                    ),
                                    CreditCard(
                                      card: snapshot.data!.card.data[index],
                                    ),
                                  ],
                                );
                              }),
                        ),
                        checkoutScreenController.selectedPayment.value == 1
                            ? Padding(
                                padding: const EdgeInsets.only(top: 60),
                                child: Center(
                                  child: CustomButton(
                                    height: 50,
                                    width: Get.width * 0.7,
                                    text: 'Continue',
                                    color: darkBlue,
                                    onPressed: () => onCardContinuePressed(
                                      snapshot.data!.card.data[
                                          checkoutScreenController
                                              .currentCard.value],
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox.shrink(),
                      ],
                    );
                  })
              : SizedBox(
                  height: Get.height * 0.25,
                ),
          checkoutScreenController.selectedPayment.value == 0
              ? Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Center(
                    child: CustomButton(
                      height: 50,
                      width: Get.width * 0.7,
                      text: 'Continue',
                      color: darkBlue,
                      onPressed: () => onContinuePressed(),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

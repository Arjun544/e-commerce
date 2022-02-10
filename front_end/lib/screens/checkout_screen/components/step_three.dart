
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../profile_screen/components/add_card.dart';
import '../../../controllers/checkout_screen_controller.dart';
import '../../../controllers/payment_controller.dart';
import '../../../models/payment_card_model.dart';
import '../../../utils/colors.dart';
import '../../../widgets/credit_card_widget.dart';
import '../../../widgets/custom_button.dart';
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
  }

  void onContinuePressed() {
    checkoutScreenController.activeStep.value += 1;
    checkoutScreenController.order['payment'] =
        checkoutScreenController.selectedPayment.value;
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
                        snapshot.data!.card.data.isEmpty
                            ? Padding(
                                padding: EdgeInsets.only(
                                  top: Get.height * 0.1,
                                ),
                                child: Center(
                                  child: Column(
                                    children: [
                                      const Text(
                                        'No Cards',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.grey),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      DottedBorder(
                                        color: Colors.black,
                                        dashPattern: [10, 10],
                                        strokeWidth: 2,
                                        strokeCap: StrokeCap.round,
                                        borderType: BorderType.RRect,
                                        radius: const Radius.circular(15),
                                        child: InkWell(
                                          onTap: () {
                                            Get.to(
                                              () => const AddCard(),
                                            );
                                          },
                                          child: Container(
                                            height: 40,
                                            width: Get.width * 0.4,
                                            alignment: Alignment.center,
                                            child: const Text(
                                              'Add Card',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox(
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
                                              groupValue:
                                                  checkoutScreenController
                                                      .currentCard.value,
                                              onChanged: (value) async {
                                                checkoutScreenController
                                                    .currentCard.value = index;

                                                checkoutScreenController
                                                        .order['card'] =
                                                    snapshot.data!.card
                                                        .data[index].id;
                                              },
                                            ),
                                          ),
                                          CreditCard(
                                            card:
                                                snapshot.data!.card.data[index],
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
                                      onPressed: () {
                                        if (snapshot.data!.card.data.isEmpty) {
                                          EasyLoading.showToast(
                                            'No card selected',
                                            toastPosition:
                                                EasyLoadingToastPosition.top,
                                            maskType: EasyLoadingMaskType.clear,
                                          );
                                        } else {
                                          onCardContinuePressed(
                                            snapshot.data!.card.data[
                                                checkoutScreenController
                                                    .currentCard.value],
                                          );
                                        }
                                      }),
                                ),
                              )
                            : const SizedBox.shrink(),
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

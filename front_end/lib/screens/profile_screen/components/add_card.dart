import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front_end/controllers/payment_controller.dart';
import 'package:front_end/models/customer_model.dart';
import 'package:front_end/utils/constants.dart';
import '../../../widgets/custom_button.dart';
import '../../../utils/colors.dart';
import 'package:get/get.dart';

class AddCard extends StatefulWidget {
  const AddCard({Key? key}) : super(key: key);

  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  final PaymentController paymentController = Get.find();

  RxString cardNumber = ''.obs;
  RxString expiryDate = ''.obs;
  RxString cardHolderName = ''.obs;
  RxString cvvCode = ''.obs;
  RxBool isCvvFocused = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    cardNumber.value = creditCardModel!.cardNumber;
    expiryDate.value = creditCardModel.expiryDate;
    cardHolderName.value = creditCardModel.cardHolderName;
    cvvCode.value = creditCardModel.cvvCode;
    isCvvFocused.value = creditCardModel.isCvvFocused;
  }

  void onAddPressed() async {
    if (formKey.currentState!.validate()) {
      CustomerModel customer = await paymentController.createCustomer(
        name: cardHolderName.value,
        cardNumber: cardNumber.value,
        expMonth: expiryDate.value.split('/')[0].toString(),
        expYear: expiryDate.value.split('/')[1].toString(),
        cvc: cvvCode.value,
      );
      log(customer.toString());
      // await getStorage.write('customerId', customer.customer.id.toString());
      // await getStorage.write(
      //     'card', customer.customer.defaultSource.toString());
      Get.back();
      setState(() {
        paymentController.getCustomerCard(
            id: getStorage.read('customerId'), card: getStorage.read('card'));
      });
    } else {
      print('invalid!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.only(top: 45, right: 12, left: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: SvgPicture.asset(
                    'assets/images/Arrow - Left.svg',
                    height: 25,
                    color: darkBlue.withOpacity(0.7),
                  ),
                ),
                const Text(
                  'Add Card',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => CreditCardWidget(
                width: Get.width,
                cardNumber: cardNumber.value,
                expiryDate: expiryDate.value,
                cardHolderName: cardHolderName.value,
                cvvCode: cvvCode.value,
                showBackView: isCvvFocused.value,
                obscureCardNumber: true,
                obscureCardCvv: false,
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: isCvvFocused.value ? Colors.black : Colors.white,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CreditCardForm(
                      formKey: formKey,
                      onCreditCardModelChange: onCreditCardModelChange,
                      obscureCvv: true,
                      obscureNumber: true,
                      cardNumber: cardNumber.value,
                      cvvCode: cvvCode.value,
                      cardHolderName: cardHolderName.value,
                      expiryDate: expiryDate.value,
                      themeColor: darkBlue,
                      cardNumberDecoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: 'Number',
                        hintText: 'XXXX XXXX XXXX XXXX',
                      ),
                      expiryDateDecoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: 'Expired Date',
                        hintText: 'XX/XX',
                      ),
                      cvvCodeDecoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: 'CVV',
                        hintText: 'XXX',
                      ),
                      cardHolderDecoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: 'Card Holder',
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CustomButton(
                      height: 50,
                      width: Get.width * 0.8,
                      text: 'Add',
                      color: darkBlue,
                      onPressed: onAddPressed,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

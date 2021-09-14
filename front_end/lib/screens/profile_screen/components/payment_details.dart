import 'dart:developer';

import 'package:card_swiper/card_swiper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front_end/models/customer_model.dart';
import 'package:front_end/models/payment_card_model.dart';
import 'package:front_end/utils/constants.dart';
import 'add_card.dart';
import '../../../controllers/payment_controller.dart';
import '../../../controllers/profile_screen_controller.dart';
import '../../../widgets/social_btn.dart';
import '../../../utils/colors.dart';
import 'package:get/get.dart';

class PaymentDetails extends StatefulWidget {
  final ProfileScreenController profileScreenController;

  PaymentDetails({required this.profileScreenController});

  @override
  _PaymentDetailsState createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  final PaymentController paymentController = Get.put(PaymentController());

  @override
  void initState() {
    log(getStorage.read('customerId').toString() +
        '   ' +
        getStorage.read('card').toString());
    if (getStorage.read('customerId') != null &&
        getStorage.read('card') != null) {
      paymentController.getCustomerCard(
          id: getStorage.read('customerId'), card: getStorage.read('card'));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 45, right: 12, left: 10),
            child: Row(
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
                  'Your Cards',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          getStorage.read('customerId') != null
              ? Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.3),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'No Cards',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.grey[400]),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
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
                            SocialButton(
                              height: 50,
                              width: Get.width * 0.27,
                              text: 'Scan',
                              icon: 'assets/images/Scan.svg',
                              color: customYellow,
                              iconColor: Colors.white,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : StreamBuilder(
                  stream: paymentController.paymentCardStreamController.stream,
                  builder: (context, AsyncSnapshot<PaymentCardModel> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox.shrink();
                    }

                    return SizedBox(
                      height: 200,
                      child: Swiper(
                        itemCount: 1,
                        itemWidth: Get.width,
                        layout: SwiperLayout.STACK,
                        loop: false,
                        onIndexChanged: (current) {
                          widget.profileScreenController.currentPaymentCard
                              .value = current;
                        },
                        itemBuilder: (context, index) => Padding(
                          padding: index ==
                                  widget.profileScreenController
                                      .currentPaymentCard.value
                              ? const EdgeInsets.only(left: 15)
                              : const EdgeInsets.all(0),
                          child: CreditCardWidget(
                            cardNumber:
                                '************${snapshot.data!.card.last4}',
                            expiryDate:
                                snapshot.data!.card.expMonth.toString() +
                                    '/' +
                                    snapshot.data!.card.expYear.toString(),
                            cardHolderName: '',
                            cvvCode: '',
                            showBackView: false,
                            cardBgColor: darkBlue,
                            cardType: CardType.visa,
                            labelCardHolder: 'Card Holder',
                            labelExpiredDate: 'Exp Date',
                            obscureCardNumber: true,
                            obscureCardCvv: true,
                            height: 175,
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            width: Get.width,
                            animationDuration:
                                const Duration(milliseconds: 1000),
                          ),
                        ),
                      ),
                    );
                  }),
        ],
      ),
    );
  }
}

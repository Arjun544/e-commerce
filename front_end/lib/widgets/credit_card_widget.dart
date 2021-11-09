import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../controllers/root_screen_controller.dart';
import '../models/userModel.dart';
import 'package:intl/intl.dart';
import '../models/payment_card_model.dart';
import '../utils/colors.dart';
import 'package:get/get.dart';

class CreditCard extends StatelessWidget {
  final Datum card;
  const CreditCard({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RootScreenController rootScreenController = Get.find();
    return Container(
      width: Get.width * 0.9,
      height: Get.height * 0.25,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
          color: darkBlue,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            const BoxShadow(
              color: Colors.grey,
              blurRadius: 10.0,
              offset: Offset(1, 1),
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/chip-card.png',
                height: 40,
                fit: BoxFit.cover,
              ),
              if (card.card.brand == 'visa') ...[
                SvgPicture.asset(
                  'assets/images/visa.svg',
                  color: Colors.white,
                  height: 70,
                ),
              ] else if (card.card.brand == 'mastercard') ...[
                SvgPicture.asset(
                  'assets/images/matercard.svg',
                  color: Colors.white,
                  height: 70,
                ),
              ] else ...[
                SvgPicture.asset(
                  'assets/images/credit-card.svg',
                  color: Colors.white,
                  height: 70,
                ),
              ],
            ],
          ),
          Text(
            '**** **** **** ${card.card.last4}',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StreamBuilder<UserModel>(
                  stream:
                      rootScreenController.currentUserStreamController.stream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox.shrink();
                    }
                    return Text(
                      toBeginningOfSentenceCase(snapshot.data!.data.username) ??
                          '',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    );
                  }),
              Row(
                children: [
                  const Text(
                    'Exp',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    card.card.expMonth.toString() +
                        '/' +
                        card.card.expYear.toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

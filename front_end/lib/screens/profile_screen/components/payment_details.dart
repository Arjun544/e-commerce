
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/constants.dart';
import '../../../widgets/credit_card_widget.dart';
import '../../../models/payment_card_model.dart';
import '../../../controllers/payment_controller.dart';
import '../../../controllers/profile_screen_controller.dart';
import '../../../utils/colors.dart';
import 'package:get/get.dart';

import 'add_card.dart';

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
    paymentController.getCustomerCard();

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
                InkWell(
                  onTap: () {
                    Get.to(
                      () => const AddCard(),
                    );
                  },
                  child: const Text(
                    'Add',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          getStorage.read('customerId') != 'Null'
              ? StreamBuilder(
                  stream: paymentController.paymentCardStreamController.stream,
                  builder: (context, AsyncSnapshot<PaymentModel> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox.shrink();
                    }
                    return snapshot.data!.card.data.isEmpty
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
                                        color: Colors.grey[500]),
                                  ),
                                  const SizedBox(
                                    height: 30,
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
                        : Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.card.data.length,
                              padding: const EdgeInsets.only(left: 15),
                              itemBuilder: (context, index) {
                                return Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CreditCard(
                                      card: snapshot.data!.card.data[index],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 20,
                                      ),
                                      child: GestureDetector(
                                        onTap: () async {
                                          await paymentController.deleteCard(
                                            id: snapshot
                                                .data!.card.data[index].id,
                                          );
                                          setState(() {
                                            paymentController.getCustomerCard();
                                          });
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                            color: customGrey,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: const Icon(
                                            CupertinoIcons.delete_simple,
                                            color: Colors.red,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                  })
              : Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.3),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'No Cards',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.grey[500]),
                        ),
                        const SizedBox(
                          height: 30,
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
        ],
      ),
    );
  }
}

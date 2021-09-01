import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:im_stepper/stepper.dart';
import '../../utils/colors.dart';
import 'package:get/get.dart';

import 'components/step_four.dart';
import 'components/step_one.dart';
import 'components/step_three.dart';
import 'components/step_two.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  RxInt activeStep = 0.obs;
  List<Widget> activeStepView = [
    StepOne(),
    StepTwo(),
    StepThree(),
    StepFour(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 45, right: 12, left: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: SvgPicture.asset(
                    'assets/images/Arrow - Left.svg',
                    height: 25,
                    color: darkBlue.withOpacity(0.7),
                  ),
                ),
                const Text(
                  'Check out',
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
            DotStepper(
              dotCount: 4,
              dotRadius: 15,
              lineConnectorsEnabled: true,
              activeStep: activeStep.value,
              shape: Shape.circle,
              spacing: 50,
              indicator: Indicator.shrink,
              onDotTapped: (tappedDotIndex) {
                activeStep.value = tappedDotIndex;
                activeStepView[activeStep.value];
              },
              fixedDotDecoration: FixedDotDecoration(
                color: Colors.grey.withOpacity(0.3),
              ),
              indicatorDecoration: const IndicatorDecoration(
                color: customYellow,
              ),
              lineConnectorDecoration: const LineConnectorDecoration(
                color: customYellow,
                strokeWidth: 3,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => Container(
                child: activeStepView[activeStep.value],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

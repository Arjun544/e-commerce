import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:im_stepper/stepper.dart';

import '../../controllers/checkout_screen_controller.dart';
import '../../utils/colors.dart';
import 'components/step_four.dart';
import 'components/step_one.dart';
import 'components/step_three.dart';
import 'components/step_two.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final CheckoutScreenController controller =
      Get.put(CheckoutScreenController());

  @override
  Widget build(BuildContext context) {
    final List<Widget> activeStepView = [
      StepOne(),
      StepTwo(
        checkoutScreenController: controller,
      ),
      StepThree(),
      StepFour(),
    ];
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 45, right: 12, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.subTotal = 0;
                    Get.back();
                  },
                  child: SvgPicture.asset(
                    'assets/images/Arrow - Left.svg',
                    height: 25,
                    color: darkBlue.withOpacity(0.7),
                  ),
                ),
                const Text(
                  'Check out',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(
            () => DotStepper(
              tappingEnabled: false,
              dotCount: 4,
              dotRadius: 15,
              lineConnectorsEnabled: true,
              activeStep: controller.activeStep.value,
              shape: Shape.circle,
              spacing: 50,
              indicator: Indicator.shrink,
              onDotTapped: (tappedDotIndex) {
                controller.activeStep.value = tappedDotIndex;
                activeStepView[controller.activeStep.value];
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
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(
            () => activeStepView[controller.activeStep.value],
          ),
        ],
      ),
    );
  }
}

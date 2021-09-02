import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../controllers/checkout_screen_controller.dart';
import 'package:im_stepper/stepper.dart';
import '../../utils/colors.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  final CheckoutScreenController controller = Get.find();

  @override
  Widget build(BuildContext context) {
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
              dotCount: 4,
              dotRadius: 15,
              lineConnectorsEnabled: true,
              activeStep: controller.activeStep.value,
              shape: Shape.circle,
              spacing: 50,
              indicator: Indicator.shrink,
              onDotTapped: (tappedDotIndex) {
                controller.activeStep.value = tappedDotIndex;
                controller.activeStepView[controller.activeStep.value];
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
            () => controller.activeStepView[controller.activeStep.value],
          ),
        ],
      ),
    );
  }
}

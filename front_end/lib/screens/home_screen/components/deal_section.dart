import 'package:flutter/material.dart';
import '../../../controllers/home_screen_controller.dart';
import '../../../utils/colors.dart';
import 'package:get/get.dart';
import 'package:slide_countdown/slide_countdown.dart';

class DealSection extends StatelessWidget {
  final HomeScreenController controller;
  const DealSection({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dealTime = controller.deals.value.deals[0].endDate.toLocal();
    final currentTime = DateTime.now();

    final diff_dy = dealTime.difference(currentTime).inDays;
    final diff_hr = dealTime.difference(currentTime).inHours;
    final diff_mn = dealTime.difference(currentTime).inMinutes;
    final diff_sc = dealTime.difference(currentTime).inSeconds;

    print(dealTime.isUtc);

    return Container(
      height: 60,
      width: Get.width,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(),
      child: SlideCountdownSeparated(
        width: 50,
        height: 40,
        withDays: true,
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        decoration: BoxDecoration(
          color: customGrey,
          borderRadius: BorderRadius.circular(10),
        ),
        duration: Duration(
          days: diff_dy,
          hours: diff_hr,
          minutes: diff_mn,
          seconds: diff_sc,
        ),
      ),
    );
  }
}

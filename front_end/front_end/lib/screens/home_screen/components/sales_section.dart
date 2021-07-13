import 'package:flutter/material.dart';
import 'package:front_end/utils/colors.dart';
import 'package:get/get.dart';

class SalesSection extends StatelessWidget {
  const SalesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.2,
      width: Get.width,
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: customYellow,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

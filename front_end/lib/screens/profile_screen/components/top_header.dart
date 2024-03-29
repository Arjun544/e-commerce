import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';

class TopHeader extends StatelessWidget {
  final String text;

  const TopHeader({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(right: 12, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => Get.back(),
              child: SvgPicture.asset(
                'assets/images/Arrow - Left.svg',
                height: 25,
                color: darkBlue.withOpacity(0.7),
              ),
            ),
            Text(
              text,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, color: darkBlue, fontSize: 16),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}

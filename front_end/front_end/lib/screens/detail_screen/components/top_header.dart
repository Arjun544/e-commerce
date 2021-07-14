import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../root_screen.dart';
import '../../../utils/colors.dart';
import 'package:get/get.dart';

class TopHeader extends StatelessWidget {
  const TopHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Get.to(() => RootScreen()),
          child: SvgPicture.asset(
            'assets/images/Arrow - Left.svg',
            height: 25,
            color: darkBlue.withOpacity(0.7),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        GestureDetector(
          onTap: () {},
          child: SvgPicture.asset(
            'assets/images/Heart.svg',
            height: 25,
            color: darkBlue.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}

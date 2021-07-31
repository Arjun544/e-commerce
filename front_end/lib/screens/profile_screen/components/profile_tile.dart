import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/colors.dart';
import 'package:get/get.dart';

class ProfileTile extends StatelessWidget {
  final String text;
  final String icon;
  final Color? iconColor;
  final VoidCallback onPressed;

  const ProfileTile(
      {Key? key,
      required this.text,
      required this.icon,
      required this.iconColor,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(),
      child: Container(
        height: Get.height * 0.08,
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: customGrey,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Container(
              height: Get.height * 0.057,
              width: Get.width * 0.12,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: iconColor!.withOpacity(0.3),
                borderRadius: BorderRadius.circular(15),
              ),
              child: SvgPicture.asset(
                icon,
                height: 25,
                color: iconColor,
              ),
            ),
            const SizedBox(width: 15),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    'assets/images/Arrow - Right.svg',
                    height: 20,
                    color: darkBlue.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocialButton extends StatelessWidget {
  final double height;
  final double width;
  final String icon;
  final String text;
  final Color color;
  final Color? iconColor;
  final VoidCallback onPressed;

  const SocialButton(
      {Key? key,
      required this.height,
      required this.width,
      required this.text,
      required this.icon,
      required this.onPressed,
      this.iconColor,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              icon,
              height: 25,
              color: iconColor,
            ),
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final double width;
  final double fontSize;
  final String text;
  final Color? color;
  final Color? textColor;
  final bool isDisable;
  final VoidCallback onPressed;

  const CustomButton(
      {Key? key,
      required this.height,
      this.fontSize = 16.0,
      required this.width,
      required this.text,
      this.textColor = Colors.white,
      this.isDisable = false,
      required this.onPressed,
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
          color: isDisable ? customGrey : color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

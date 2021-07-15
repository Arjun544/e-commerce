import 'package:flutter/material.dart';
import 'package:front_end/services/api_services.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final double width;
  final String text;
  final Color color;
  final VoidCallback onPressed;

  const CustomButton(
      {Key? key,
      required this.height,
      required this.width,
      required this.text,
      required this.onPressed,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

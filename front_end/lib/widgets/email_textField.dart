import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/colors.dart';
import 'package:get/get.dart';

class EmailTextField extends StatelessWidget {
  final String text;
  final String icon;
  final TextEditingController controller;

  EmailTextField({
    Key? key,
    required this.text,
    required this.controller,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 50,
        width: Get.width * 0.85,
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          color: customGrey,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 2.0,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              height: 25,
              color: darkBlue.withOpacity(0.4),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: controller,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: text,
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

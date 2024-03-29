import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../controllers/register_screen_controller.dart';
import '../utils/colors.dart';

class PassTextField extends StatelessWidget {
  final String text;
  final String icon;
  final double width;
  final TextEditingController controller;
  final RegisterScreenController? registerScreenController;

  PassTextField({
    Key? key,
    required this.text,
    required this.icon,
    required this.width,
    required this.controller,
    this.registerScreenController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 50,
        width: width,
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
              child: Obx(
                () => TextField(
                  controller: controller,
                  obscureText: registerScreenController!.isPasswordHide.value
                      ? true
                      : false,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: text,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                registerScreenController!.togglePassword();
              },
              child: Obx(
                () => SvgPicture.asset(
                  registerScreenController!.isPasswordHide.value
                      ? 'assets/images/Hide.svg'
                      : 'assets/images/Show.svg',
                  height: 25,
                  color: darkBlue.withOpacity(0.4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

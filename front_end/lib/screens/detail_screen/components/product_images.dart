import 'package:flutter/material.dart';
import '../../../controllers/detail_screen_controller.dart';
import 'package:get/get.dart';

class ProductImages extends StatelessWidget {
  final DetailScreenController controller;

  ProductImages({required this.controller});

  final List<Color> colors = [
    Colors.lightBlue,
    Colors.amber,
    Colors.lightGreenAccent,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Obx(
          () => Container(
            height: Get.height * 0.4,
            width: Get.width,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              color: colors[controller.currentImage.value],
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        Container(
          width: Get.width,
          alignment: Alignment.center,
          height: 50,
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(bottom: 5),
            scrollDirection: Axis.horizontal,
            itemCount: colors.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  controller.currentImage.value = index;
                },
                child: Container(
                  width: 50,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: colors[index],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      width: 2,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

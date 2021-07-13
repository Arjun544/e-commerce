
import 'package:flutter/material.dart';
import '../../../controllers/home_screen_controller.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../utils/colors.dart';

class SalesSection extends StatelessWidget {
  final HomeScreenController controller;

  const SalesSection({Key? key, required this.controller});
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: PageView.builder(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        controller: controller.salesPageController,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              const SalesItem(),
              Positioned.fill(
                bottom: 25,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SmoothPageIndicator(
                    controller: controller.salesPageController,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                      expansionFactor: 2,
                      dotHeight: 6,
                      dotWidth: 6,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class SalesItem extends StatelessWidget {
  const SalesItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.18,
      width: Get.width,
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        color: samWhite,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
              ),
              const Text(
                'Arjun Mahar',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              const SizedBox(height: 20),
              const Text(
                'HOT SALE',
                style: TextStyle(
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.green),
              ),
            ],
          ),
          Image.asset(
            'assets/shirt.png',
            height: 120,
          )
        ],
      ),
    );
  }
}

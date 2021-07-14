import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/draggable_home.dart';
import 'package:get/get.dart';

import '../../controllers/detail_screen_controller.dart';
import 'components/product_details.dart';
import 'components/product_images.dart';
import 'components/top_header.dart';

class DetailScreen extends StatelessWidget {
  final DetailScreenController detailScreenController =
      Get.put(DetailScreenController());

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      curvedBodyRadius: 0,
      headerExpandedHeight: 0.5,
      title: const TopHeader(),
      headerWidget: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 45, right: 12, left: 10),
          child: Column(
            children: [
              const TopHeader(),
              const SizedBox(height: 20),
              ProductImages(
                controller: detailScreenController,
              ),
            ],
          ),
        ),
      ),
      body: [
        ProductDetails(controller: detailScreenController),
      ],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: customYellow,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Badge(
                badgeContent: const Text(
                  '2',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: 12),
                ),
                badgeColor: Colors.white,
                position: BadgePosition.topEnd(top: 5, end: 5),
                child: SvgPicture.asset(
                  'assets/images/Bag.svg',
                  height: 30,
                  color: Colors.white,
                ),
              ),
            ),
            CustomButton(
              height: 50,
              width: Get.width * 0.5,
              text: 'Add to Cart',
              color: darkBlue,
            ),
          ],
        ),
      ),
    );
  }
}

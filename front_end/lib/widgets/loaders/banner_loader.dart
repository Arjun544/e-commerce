import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class BannerLoader extends StatelessWidget {
  final double height;
  const BannerLoader({Key? key,required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.3),
      highlightColor: Colors.grey.withOpacity(0.5),
      child: Container(
        height: height,
        width: Get.width,
        margin: const EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.7),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

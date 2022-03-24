import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../models/product_Model.dart' as model;
import '../../../controllers/detail_screen_controller.dart';
import 'package:get/get.dart';

class ProductImages extends StatelessWidget {
  final List<model.Image> images;
  final String thumbnail;
  final DetailScreenController controller;

  ProductImages(
      {required this.controller,
      required this.images,
      required this.thumbnail});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Obx(
          () => Container(
            height: Get.height * 0.42,
            width: Get.width,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                fit: BoxFit.contain,
                image: CachedNetworkImageProvider(
                  controller.currentImage.value == 5
                      ? thumbnail
                      : images[controller.currentImage.value].url,
                ),
              ),
            ),
          ),
        ),
        images.isEmpty
            ? const SizedBox.shrink()
            : Container(
                width: Get.width,
                alignment: Alignment.center,
                height: 60,
                margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(bottom: 5, top: 5, left: 5),
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        controller.currentImage.value = index;
                      },
                      child: Obx(
                        () => Container(
                          width: 50,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: controller.currentImage.value == index
                                ? Border.all(
                                    width: 2,
                                    color: Colors.white,
                                  )
                                : Border.all(
                                    width: 0, color: Colors.transparent),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              imageUrl: images[index].url,
                              fit: BoxFit.cover,
                            ),
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CategoryLoader extends StatelessWidget {
  const CategoryLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, bottom: 10, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Category',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const Text(
                'View all',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.grey),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 0,
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey.withOpacity(0.3),
          highlightColor: Colors.grey.withOpacity(0.4),
          child: Column(
            children: [
              Container(
                height: Get.height * 0.16,
                child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: 6,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

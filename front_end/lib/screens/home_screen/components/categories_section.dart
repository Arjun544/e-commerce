import 'package:flutter/material.dart';
import '../../../models/category_model.dart';
import 'package:get/get.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          padding: const EdgeInsets.only(left: 15),
          itemBuilder: (context, index) {
            return Container(
              constraints: BoxConstraints(minWidth: Get.width * 0.3),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: categories[index].color,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Icon(
                    categories[index].icon,
                  ),
                  const SizedBox(width: 10),
                  Text(categories[index].name),
                ],
              ),
            );
          }),
    );
  }
}

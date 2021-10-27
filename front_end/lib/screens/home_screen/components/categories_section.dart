import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../filter_products_screen/filter_products_screen.dart';
import '../../../utils/colors.dart';
import 'package:intl/intl.dart';
import '../../../controllers/home_screen_controller.dart';
import '../../../models/category_model.dart';
import '../../../widgets/loaders/category_loader.dart';
import 'package:get/get.dart';

import 'all_catogories.dart';

class CategoriesSection extends StatelessWidget {
  CategoriesSection({Key? key}) : super(key: key);

  final HomeScreenController homeScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: homeScreenController.categoriesStreamController.stream,
        builder: (context, AsyncSnapshot<CategoryModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CategoryLoader();
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 10, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Category',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    InkWell(
                      onTap: () => Get.to(() => AllCategories(
                            categories: snapshot.data!.categoryList,
                          )),
                      child: const Text(
                        'View all',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              GridView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.categoryList.length > 6
                      ? 6
                      : snapshot.data!.categoryList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemBuilder: (context, index) {
                    var category = snapshot.data!.categoryList[index];
                    return InkWell(
                      onTap: () => {
                        Get.to(
                          () => FilterProductsScreen(
                            filterBy: category.name,
                            categoryId: category.id,
                            isSubCategoryFilter: false,
                          ),
                        ),
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: customGrey,
                              image: DecorationImage(
                                fit: BoxFit.contain,
                                image: CachedNetworkImageProvider(
                                  category.icon,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            toBeginningOfSentenceCase(category.name) ??
                                'No name',
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          );
        });
  }
}

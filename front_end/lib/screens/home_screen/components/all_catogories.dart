import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../filter_products_screen/filter_products_screen.dart';
import 'package:intl/intl.dart';
import '../../../models/category_model.dart';
import '../../../utils/colors.dart';
import 'package:get/get.dart';

class AllCategories extends StatefulWidget {
  final List<CategoryList> categories;

  const AllCategories({required this.categories});

  @override
  _AllCategoriesState createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  RxInt selectedCategory = 0.obs;
  List categoriesList = [].obs;

  void onCategoryTap(int index) {
    selectedCategory.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 45, right: 12, left: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: SvgPicture.asset(
                    'assets/images/Arrow - Left.svg',
                    height: 25,
                    color: darkBlue.withOpacity(0.7),
                  ),
                ),
                const Text(
                  'Categories',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: Get.height,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.all(0),
                        itemCount: widget.categories.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => onCategoryTap(index),
                            child: Obx(
                              () => Container(
                                height: 100,
                                margin: const EdgeInsets.only(bottom: 6),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                  color: selectedCategory.value == index
                                      ? customYellow.withOpacity(0.5)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        imageUrl: widget.categories[index].icon,
                                        fit: BoxFit.fitWidth,
                                        height: 50,
                                        width: 65,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Text(
                                        toBeginningOfSentenceCase(widget
                                                .categories[index].name) ??
                                            'No name',
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.fade,
                                        maxLines: 2,
                                        style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Obx(
                      () => Container(
                        height: Get.height,
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: widget.categories[selectedCategory.value]
                                .subCategories.isEmpty
                            ? const Center(
                                child: Text(
                                  'No sub categories',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )
                            : Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(
                                        () => FilterProductsScreen(
                                          filterBy: widget
                                              .categories[
                                                  selectedCategory.value]
                                              .name,
                                          categoryId: widget
                                              .categories[
                                                  selectedCategory.value]
                                              .id,
                                          isSubCategoryFilter: false,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 50,
                                      margin: const EdgeInsets.all(10),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'All',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SvgPicture.asset(
                                            'assets/images/Arrow - Right.svg',
                                            height: 20,
                                            color: darkBlue.withOpacity(0.5),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    itemCount: widget
                                        .categories[selectedCategory.value]
                                        .subCategories
                                        .length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          Get.to(
                                            () => FilterProductsScreen(
                                              categoryId: widget
                                                  .categories[
                                                      selectedCategory.value]
                                                  .id,
                                              isSubCategoryFilter: true,
                                              filterBy: widget
                                                  .categories[
                                                      selectedCategory.value]
                                                  .subCategories[index].name,
                                              subCategory: widget
                                                  .categories[
                                                      selectedCategory.value]
                                                  .subCategories[index].name,
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: 50,
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                toBeginningOfSentenceCase(
                                                      widget
                                                              .categories[
                                                                  selectedCategory
                                                                      .value]
                                                              .subCategories[
                                                          index].name,
                                                    ) ??
                                                    'No name',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SvgPicture.asset(
                                                'assets/images/Arrow - Right.svg',
                                                height: 20,
                                                color:
                                                    darkBlue.withOpacity(0.5),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

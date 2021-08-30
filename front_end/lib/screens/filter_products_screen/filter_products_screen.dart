import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../controllers/filtered_products_screen_controller.dart';
import '../../controllers/home_screen_controller.dart';
import 'package:lottie/lottie.dart';
import '../../models/product_Model.dart';
import '../detail_screen/detail_screen.dart';
import '../../utils/colors.dart';
import '../../widgets/loaders/featured_loader.dart';
import '../../widgets/product_Item.dart';
import 'package:get/get.dart';

class FilterProductsScreen extends StatefulWidget {
  final String filterBy;
  final bool isSubCategoryFilter;
  final String categoryId;
  final String? subCategory;

  FilterProductsScreen(
      {required this.categoryId,
      required this.filterBy,
      required this.isSubCategoryFilter,
      this.subCategory});

  @override
  _FilterProductsScreenState createState() => _FilterProductsScreenState();
}

class _FilterProductsScreenState extends State<FilterProductsScreen> {
  final FilteredProductsScreenController filteredProductsScreenController =
      Get.put(FilteredProductsScreenController());
  final HomeScreenController homeScreenController = Get.find();

  @override
  void initState() {
    widget.isSubCategoryFilter
        ? filteredProductsScreenController.getFilteredProducts(
            id: widget.categoryId,
            hasQueryParam: true,
            subCategory: widget.subCategory)
        : filteredProductsScreenController.getFilteredProducts(
            id: widget.categoryId, hasQueryParam: false);

    super.initState();
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
                Text(
                  toBeginningOfSentenceCase(widget.filterBy) ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder(
                stream: filteredProductsScreenController
                    .filteredProductsStreamController.stream,
                builder: (context, AsyncSnapshot<ProductModel> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Expanded(
                      child: FeaturedLoader(),
                    );
                  }
                  return snapshot.data!.products.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 80),
                          child: Column(
                            children: [
                              Lottie.asset('assets/empty.json',
                                  height: Get.height * 0.3),
                              const Text(
                                'No products',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black45),
                              ),
                            ],
                          ),
                        )
                      : StaggeredGridView.countBuilder(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          padding: const EdgeInsets.only(
                              right: 12, left: 12, bottom: 70),
                          itemCount: snapshot.data!.products.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            Product product = snapshot.data!.products[index];

                            return GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => DetailScreen(
                                    product: product,
                                  ),
                                );
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 7),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: ProductItem(
                                  homeScreenController: homeScreenController,
                                  product: product,
                                ),
                              ),
                            );
                          },
                          staggeredTileBuilder: (index) {
                            return StaggeredTile.count(
                                1, index.isEven ? 1.4 : 1.5);
                          });
                }),
          ],
        ),
      ),
    );
  }
}

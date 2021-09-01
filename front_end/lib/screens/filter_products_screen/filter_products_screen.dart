import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import '../home_screen/components/filter_bottomSheet.dart';
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

    log('rebuild');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 45, right: 12, left: 10),
        child: Obx(
          () => Column(
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
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => Get.bottomSheet(
                      FilterBottomSheet(),
                      isScrollControlled: true,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IgnorePointer(
                        child: Badge(
                          showBadge: filteredProductsScreenController
                                      .isSorting.value ==
                                  true
                              ? true
                              : false,
                          badgeContent: const Text(
                            '1',
                            style: TextStyle(
                              fontSize: 8,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: SvgPicture.asset(
                            'assets/images/Filter.svg',
                            height: 18,
                            color: darkBlue,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              filteredProductsScreenController.isSorting.value == true
                  ? Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        top: 20,
                      ),
                      child: Row(
                        children: [
                          const Text(
                            'Sorting by ',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            filteredProductsScreenController.appliedSort.value,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
              const SizedBox(
                height: 20,
              ),
              filteredProductsScreenController.isSorting.value == true
                  ? StreamBuilder(
                      stream: filteredProductsScreenController
                          .sortedProductsStreamController.stream,
                      builder:
                          (context, AsyncSnapshot<List<Product>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Expanded(
                            child: FeaturedLoader(),
                          );
                        }
                        return snapshot.data!.isEmpty
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
                            : Expanded(
                                child: StaggeredGridView.countBuilder(
                                    shrinkWrap: true,
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 15,
                                    padding: const EdgeInsets.only(
                                        right: 12, left: 12, bottom: 20),
                                    itemCount: snapshot.data!.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      Product product = snapshot.data![index];

                                      return GestureDetector(
                                        onTap: () {
                                          Get.to(
                                            () => DetailScreen(
                                              product: product,
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.2),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                          ),
                                          child: ProductItem(
                                            homeScreenController:
                                                homeScreenController,
                                            product: product,
                                          ),
                                        ),
                                      );
                                    },
                                    staggeredTileBuilder: (index) {
                                      return StaggeredTile.count(
                                          1, index.isEven ? 1.5 : 1.6);
                                    }),
                              );
                      })
                  : StreamBuilder(
                      stream: filteredProductsScreenController
                          .filteredProductsStreamController.stream,
                      builder: (context, AsyncSnapshot<ProductModel> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                            : Expanded(
                                child: StaggeredGridView.countBuilder(
                                    shrinkWrap: true,
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 15,
                                    padding: const EdgeInsets.only(
                                        right: 12, left: 12, bottom: 20),
                                    itemCount: snapshot.data!.products.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      Product product =
                                          snapshot.data!.products[index];
                                      filteredProductsScreenController
                                          .filteredProducts
                                          .add(product);
                                      return GestureDetector(
                                        onTap: () {
                                          Get.to(
                                            () => DetailScreen(
                                              product: product,
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              right: 7, left: 7, bottom: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.2),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                          ),
                                          child: ProductItem(
                                            homeScreenController:
                                                homeScreenController,
                                            product: product,
                                          ),
                                        ),
                                      );
                                    },
                                    staggeredTileBuilder: (index) {
                                      return StaggeredTile.count(
                                          1, index.isEven ? 1.5 : 1.6);
                                    }),
                              );
                      }),
            ],
          ),
        ),
      ),
    );
  }
}

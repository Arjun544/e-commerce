import 'dart:developer';

import 'package:another_xlider/another_xlider.dart';
import 'package:flutter/material.dart';
import '../../../models/product_Model.dart';
import '../../../widgets/custom_button.dart';
import '../../../controllers/filtered_products_screen_controller.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import '../../../utils/colors.dart';

class FilterBottomSheet extends StatefulWidget {
  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final FilteredProductsScreenController filteredProductsScreenController =
      Get.put(FilteredProductsScreenController());

  String selectedSortBy = '';
  double selectedRating = 0;
  double startPrice = 0;
  double endPrice = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.9,
      padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
      decoration: const BoxDecoration(
        color: customGrey,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 40,
                ),
                const Text(
                  'Filters',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Text(
                    'Close',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Text(
              'Sort By',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            CustomSortButton(
              selectedSortBy: selectedSortBy,
              controller: filteredProductsScreenController,
            ),
            const SizedBox(height: 20),
            const Text(
              'Rating',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            CustomRatingButton(
              selectedRating: selectedRating,
              controller: filteredProductsScreenController,
            ),
            const SizedBox(height: 20),
            const Text(
              'Price',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            PriceSlider(
              startPrice: startPrice,
              endPrice: endPrice,
              controller: filteredProductsScreenController,
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: CustomButton(
                height: 50,
                width: Get.width * 0.5,
                text: 'Clear',
                color: darkBlue,
                onPressed: () {
                  filteredProductsScreenController.isSorting.value = false;
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomSortButton extends StatelessWidget {
  final FilteredProductsScreenController controller;
  String selectedSortBy;

  CustomSortButton({required this.selectedSortBy, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GroupButton(
      spacing: 10,
      isRadio: true,
      buttonWidth: Get.width * 0.89,
      buttonHeight: Get.height * 0.05,
      direction: Axis.vertical,
      onSelected: (index, isSelected) {
        switch (index) {
          case 0:
            selectedSortBy = 'onSale';
            break;
          case 1:
            selectedSortBy = 'newest';
            break;
          case 2:
            selectedSortBy = 'oldest';
            break;
          case 3:
            selectedSortBy = 'Low to High Pricing';
            break;
          case 4:
            selectedSortBy = 'High to Low Pricing';
            break;
          default:
        }

        switch (selectedSortBy) {
          case 'onSale':
            controller.sortedProductsStreamController.add(controller
                .filteredProducts
                .where((element) => element.onSale == true)
                .toList());
            break;
          case 'newest':
            controller.filteredProducts
                .sort((a, b) => b.dateCreated.compareTo(a.dateCreated));
            controller.sortedProductsStreamController
                .add(controller.filteredProducts.toList());
            break;
          case 'oldest':
            controller.filteredProducts
                .sort((a, b) => a.dateCreated.compareTo(b.dateCreated));
            controller.sortedProductsStreamController
                .add(controller.filteredProducts.toList());
            break;
          case 'Low to High Pricing':
            controller.filteredProducts
                .sort((a, b) => a.price.compareTo(b.price));
            controller.sortedProductsStreamController
                .add(controller.filteredProducts);
            break;
          case 'High to Low Pricing':
            controller.filteredProducts
                .sort((a, b) => b.price.compareTo(a.price));
            controller.sortedProductsStreamController
                .add(controller.filteredProducts);
            break;
          default:
        }
        controller.isSorting.value = true;
        controller.appliedSort.value = selectedSortBy;
        Get.back();
      },
      buttons: [
        'On Sale',
        'Newest',
        'Oldest',
        'Low to High Pricing',
        'High to Low Pricing',
      ],
      selectedTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Colors.white,
      ),
      unselectedTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
        color: Colors.black,
      ),
      selectedColor: Colors.blue,
      unselectedColor: Colors.transparent,
      selectedBorderColor: Colors.transparent,
      unselectedBorderColor: Colors.grey,
      borderRadius: BorderRadius.circular(10.0),
    );
  }
}

// ignore: must_be_immutable
class CustomRatingButton extends StatelessWidget {
  double selectedRating;
  final FilteredProductsScreenController controller;

  CustomRatingButton({required this.selectedRating, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GroupButton(
      spacing: 10,
      isRadio: true,
      buttonWidth: Get.width * 0.425,
      buttonHeight: Get.height * 0.05,
      direction: Axis.horizontal,
      onSelected: (index, isSelected) {
        switch (index) {
          case 0:
            selectedRating = 2;
            break;
          case 1:
            selectedRating = 3;
            break;
          case 2:
            selectedRating = 4;
            break;
          case 3:
            selectedRating = 5;
            break;
          default:
        }

        double calcAvgRating(List<Review> reviews) {
          double averageRating = 0;
          if (reviews.isNotEmpty) {
            averageRating = reviews
                    .map((m) => double.parse(m.rating.toString()))
                    .reduce((a, b) => a + b) /
                reviews.length;
          }
          return averageRating;
        }

        if (selectedRating >= 0 && selectedRating <= 2) {
          controller.sortedProductsStreamController.add(controller
              .filteredProducts.reversed
              .where((element) =>
                  calcAvgRating(element.reviews) >= 0 &&
                  calcAvgRating(element.reviews) <= 2)
              .toList());
        } else if (selectedRating >= 2 && selectedRating <= 3) {
          controller.sortedProductsStreamController.add(controller
              .filteredProducts.reversed
              .where((element) =>
                  calcAvgRating(element.reviews) >= 2 &&
                  calcAvgRating(element.reviews) <= 3)
              .toList());
        } else if (selectedRating >= 3 && selectedRating <= 4) {
          controller.sortedProductsStreamController.add(controller
              .filteredProducts.reversed
              .where((element) =>
                  calcAvgRating(element.reviews) >= 3 &&
                  calcAvgRating(element.reviews) <= 4)
              .toList());
        } else if (selectedRating >= 4 && selectedRating <= 5) {
          controller.sortedProductsStreamController.add(controller
              .filteredProducts.reversed
              .where((element) =>
                  calcAvgRating(element.reviews) >= 4 &&
                  calcAvgRating(element.reviews) <= 5)
              .toList());
        }
        controller.isSorting.value = true;
        Get.back();
      },
      buttons: [
        '0 - 2',
        '2 - 3',
        '3 - 4',
        '4 - 5',
      ],
      selectedTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Colors.white,
      ),
      unselectedTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
        color: Colors.black,
      ),
      selectedColor: Colors.blue,
      unselectedColor: Colors.transparent,
      selectedBorderColor: Colors.transparent,
      unselectedBorderColor: Colors.grey,
      borderRadius: BorderRadius.circular(10.0),
    );
  }
}

// ignore: must_be_immutable
class PriceSlider extends StatelessWidget {
  double startPrice;
  double endPrice;
  final FilteredProductsScreenController controller;

  PriceSlider(
      {required this.startPrice,
      required this.endPrice,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return FlutterSlider(
      values: [0, 20000],
      max: 100000,
      min: 0,
      onDragCompleted: (value, one, two) {
        startPrice = one;
        endPrice = two;
        controller.sortedProductsStreamController.add(controller
            .filteredProducts
            .where((element) =>
                element.price >= startPrice && element.price <= endPrice)
            .toList());

        controller.isSorting.value = true;
        Get.back();
      },
      step: const FlutterSliderStep(step: 1000),
      rangeSlider: true,
      rightHandler: FlutterSliderHandler(
        decoration: BoxDecoration(
          color: Colors.blue[300],
          shape: BoxShape.circle,
        ),
        foregroundDecoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 5, color: Colors.white),
        ),
      ),
      handler: FlutterSliderHandler(
        decoration: BoxDecoration(
          color: Colors.blue[300],
          shape: BoxShape.circle,
        ),
        foregroundDecoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 5, color: Colors.white),
        ),
      ),
      tooltip: FlutterSliderTooltip(
        textStyle: const TextStyle(fontSize: 26),
        leftSuffix: const Text(
          ' Pkr',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        rightSuffix: const Text(
          ' Pkr',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

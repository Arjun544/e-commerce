
import 'package:another_xlider/another_xlider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import '../../../utils/colors.dart';
import '../../filteredProductsScreens.dart';

class FilterBottomSheet extends StatefulWidget {
  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String selectedSortBy = '';
  int selectedTime = 0;
  double selectedRating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
            const Text(
              'Sort By',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            CustomSortButton(selectedSortBy: selectedSortBy),
            const SizedBox(height: 20),
            const Text(
              'Time',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            CustomTimeButton(selectedTime: selectedTime),
            const SizedBox(height: 20),
            const Text(
              'Rating',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            CustomRatingButton(selectedRating: selectedRating),
            const SizedBox(height: 20),
            const Text(
              'Price',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            const PriceSlider(),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomSortButton extends StatelessWidget {
  String selectedSortBy;

  CustomSortButton({required this.selectedSortBy});

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
        Get.to(
          () => const FilteredProductsScreen(),
        );
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
class CustomTimeButton extends StatelessWidget {
  int selectedTime;

  CustomTimeButton({required this.selectedTime});

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
            selectedTime = 7;
            break;
          case 1:
            selectedTime = 30;
            break;
          case 2:
            selectedTime = 182;
            break;
          case 3:
            selectedTime = 365;
            break;
          default:
        }
        Get.to(
          () => const FilteredProductsScreen(),
        );
      },
      buttons: [
        '7 Days',
        '30 Days',
        '6 Months',
        '1 Year',
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

  CustomRatingButton({required this.selectedRating});

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
        Get.to(
          () => const FilteredProductsScreen(),
        );
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

class PriceSlider extends StatelessWidget {
  const PriceSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterSlider(
      values: [0, 20000],
      max: 100000,
      min: 0,
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
        leftSuffix: const Text(
          ' Pkr',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        rightSuffix: const Text(
          ' Pkr',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

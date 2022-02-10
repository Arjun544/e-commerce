import 'package:flutter/material.dart';
import '../utils/colors.dart';
import 'package:get/get.dart';

class PaginationWidget extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final bool hasNext;
  final bool hasPrev;
  final ValueChanged<int?>? onChanged;

  const PaginationWidget(
      {Key? key,
      required this.currentPage,
      required this.totalPages,
      required this.hasNext,
      required this.hasPrev,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height * 0.08,
      margin: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
      decoration: BoxDecoration(
        color: customGrey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            'Showing',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
          Container(
            width: 80,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButtonHideUnderline(
              child: Padding(
                padding: const EdgeInsets.only(left: 14.0, right: 6),
                child: DropdownButton<int>(
                  value: currentPage,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black87),
                  isExpanded: true,
                  iconEnabledColor: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  items: List.generate(
                    totalPages,
                    (index) => DropdownMenuItem<int>(
                      value: index + 1,
                      child: Text((index + 1).toString()),
                    ),
                  ),
                  onChanged: onChanged,
                ),
              ),
            ),
          ),
          const Text(
            'of',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          Text(
            totalPages.toString(),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

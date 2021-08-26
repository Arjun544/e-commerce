import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilteredProductsScreen extends StatelessWidget {
  const FilteredProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            const Text('filter'),
            IconButton(
              onPressed: () {
                Get.back(closeOverlays: true);
              },
              iconSize: 40,
              icon: Icon(Icons.ac_unit),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../widgets/product_Item.dart';
import '../../../widgets/loaders/featured_loader.dart';
import 'package:get/get.dart';

import '../../../controllers/detail_screen_controller.dart';
import '../../../controllers/home_screen_controller.dart';
import '../../../models/product_Model.dart';
import '../../../utils/colors.dart';
import '../../detail_screen/detail_screen.dart';

class SimilarSection extends StatefulWidget {
  final String categoryId;
  final String currentId;
  final HomeScreenController homeScreenController;
  final DetailScreenController detailScreenController;

  SimilarSection({
    required this.homeScreenController,
    required this.detailScreenController,
    required this.categoryId,
    required this.currentId,
  });

  @override
  _SimilarSectionState createState() => _SimilarSectionState();
}

class _SimilarSectionState extends State<SimilarSection> {
  @override
  void initState() {
    widget.detailScreenController.getSimilarProducts(
        categoryId: widget.categoryId, currentId: widget.currentId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.detailScreenController.similarProductsController.stream,
        builder: (context, AsyncSnapshot<ProductModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const FeaturedLoader();
          }
          return StaggeredGridView.countBuilder(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              padding: const EdgeInsets.only(bottom: 10, top: 15),
              itemCount: snapshot.data!.products.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                Product product = snapshot.data!.products[index];
                return GestureDetector(
                  onTap: () {
                    Get.back();
                    Get.to(
                      () => DetailScreen(
                        product: product,
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    decoration: const BoxDecoration(
                      color: customGrey,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: ProductItem(
                      homeScreenController: widget.homeScreenController,
                      product: product,
                    ),
                  ),
                );
              },
              staggeredTileBuilder: (index) {
                return StaggeredTile.count(1, index.isEven ? 1.6 : 1.6);
              });
        });
  }
}

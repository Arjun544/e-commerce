import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../widgets/PaginationWidget.dart';
import '../../../widgets/product_Item.dart';
import '../../../widgets/loaders/featured_loader.dart';
import 'package:get/get.dart';

import '../../../controllers/cart_screen_controller.dart';
import '../../../controllers/home_screen_controller.dart';
import '../../../models/product_Model.dart';
import '../../detail_screen/detail_screen.dart';

class FeaturedSection extends StatelessWidget {
  final HomeScreenController homeScreenController;
  final CartScreenController cartScreenController;

  FeaturedSection(
      {required this.homeScreenController, required this.cartScreenController});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: homeScreenController.featuredProductsStreamController.stream,
        builder: (context, AsyncSnapshot<ProductModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const FeaturedLoader();
          }
          return Column(
            children: [
              StaggeredGridView.countBuilder(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 10,
                  padding:
                      const EdgeInsets.only(right: 12, left: 12, bottom: 20),
                  itemCount: snapshot.data!.results.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    Product product = snapshot.data!.results[index];

                    return GestureDetector(
                      onTap: () {
                        Get.to(
                          () => DetailScreen(
                            product: product,
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
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
                    return StaggeredTile.count(1, index.isEven ? 1.5 : 1.6);
                  }),
              PaginationWidget(
                currentPage: snapshot.data?.page ?? 0,
                totalPages: snapshot.data?.totalPages ?? 0,
                hasNext: snapshot.data?.hasNextPage ?? false,
                hasPrev: snapshot.data?.hasPrevPage ?? false,
                onChanged: (value) {
                  homeScreenController.handleFeaturedPagination(value!);
                },
              ),
            ],
          );
        });
  }
}

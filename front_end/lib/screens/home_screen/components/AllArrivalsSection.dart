import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../profile_screen/components/top_header.dart';
import '../../../widgets/PaginationWidget.dart';
import '../../../widgets/product_Item.dart';
import '../../../widgets/loaders/featured_loader.dart';
import 'package:get/get.dart';

import '../../../controllers/cart_screen_controller.dart';
import '../../../controllers/home_screen_controller.dart';
import '../../../models/product_Model.dart';
import '../../detail_screen/detail_screen.dart';

class AllArrivalsSection extends StatefulWidget {
  final HomeScreenController homeScreenController;
  final CartScreenController cartScreenController;

  AllArrivalsSection(
      {required this.homeScreenController, required this.cartScreenController});

  @override
  State<AllArrivalsSection> createState() => _AllArrivalsSectionState();
}

class _AllArrivalsSectionState extends State<AllArrivalsSection> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    await widget.homeScreenController.getNewArrivalProducts(page: 1);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 12.0, left: 8, bottom: 20),
            child: TopHeader(text: 'New Arrivals'),
          ),
          StreamBuilder(
              stream: widget
                  .homeScreenController.arrivalProductsStreamController.stream,
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
                        padding: const EdgeInsets.only(
                            right: 12, left: 12, bottom: 20),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 7),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: ProductItem(
                                homeScreenController:
                                    widget.homeScreenController,
                                product: product,
                              ),
                            ),
                          );
                        },
                        staggeredTileBuilder: (index) {
                          return StaggeredTile.count(
                              1, index.isEven ? 1.5 : 1.6);
                        }),
                    PaginationWidget(
                      currentPage: snapshot.data?.page ?? 0,
                      totalPages: snapshot.data?.totalPages ?? 0,
                      hasNext: snapshot.data?.hasNextPage ?? false,
                      hasPrev: snapshot.data?.hasPrevPage ?? false,
                      onChanged: (value) {
                        widget.homeScreenController
                            .handleNewArrivalsPagination(value!);
                      },
                    ),
                  ],
                );
              }),
        ],
      ),
    );
  }
}

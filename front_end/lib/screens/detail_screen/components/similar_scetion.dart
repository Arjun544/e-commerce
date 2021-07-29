import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../controllers/detail_screen_controller.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import '../../../controllers/home_screen_controller.dart';
import '../../../controllers/wishlist_controller.dart';
import '../../../models/product_Model.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
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
    widget.detailScreenController.getProductsByCategory(
        categoryId: widget.categoryId, currentId: widget.currentId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.detailScreenController.byCategoryController.stream,
        builder: (context, AsyncSnapshot<ProductModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }
          return StaggeredGridView.countBuilder(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              padding: const EdgeInsets.only(bottom: 70, top: 15),
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
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: customGrey,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: BuildItem(
                      homeScreenController: widget.homeScreenController,
                      product: product,
                    ),
                  ),
                );
              },
              staggeredTileBuilder: (index) {
                return StaggeredTile.count(1, index.isEven ? 1.4 : 1.5);
              });
        });
  }
}

class BuildItem extends StatelessWidget {
  final Product product;
  final HomeScreenController homeScreenController;

  BuildItem({required this.product, required this.homeScreenController});

  final WishListController wishListController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: CachedNetworkImage(
                imageUrl: product.image.toString(),
                fit: BoxFit.contain,
                width: Get.width * 0.5,
              ),
            ),
            PreferenceBuilder<List<String>>(
                preference: sharedPreferences
                    .getStringList('favListIds', defaultValue: []),
                builder: (context, snapshot) {
                  wishListController.ids = snapshot;
                  return LikeButton(
                    mainAxisAlignment: MainAxisAlignment.end,
                    size: 20,
                    isLiked: snapshot.contains(product.id) ? true : false,
                    circleColor: const CircleColor(
                      start: Colors.pink,
                      end: Colors.pink,
                    ),
                    bubblesColor: BubblesColor(
                      dotPrimaryColor: Colors.pink,
                      dotSecondaryColor: Colors.pink.withOpacity(0.5),
                    ),
                    likeBuilder: (bool isLiked) {
                      return isLiked
                          ? SvgPicture.asset(
                              'assets/images/Heart.svg',
                              color: Colors.pink,
                            )
                          : SvgPicture.asset(
                              'assets/images/Heart-Outline.svg',
                              color: Colors.black,
                            );
                    },
                    onTap: (isLiked) async {
                      snapshot.contains(product.id)
                          ? snapshot.remove(product.id)
                          : snapshot.add(product.id);
                      await sharedPreferences.setStringList(
                          'favListIds', snapshot);
                      return !isLiked;
                    },
                  );
                }),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                '\$ ${product.price.toString()}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

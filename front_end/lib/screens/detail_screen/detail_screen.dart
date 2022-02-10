import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controllers/cart_screen_controller.dart';
import '../../controllers/detail_screen_controller.dart';
import '../../controllers/home_screen_controller.dart';
import '../../models/product_Model.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/draggable_detail.dart';
import '../cart_screen/cart_screen.dart';
import '../register_screen/register_screen.dart';
import 'components/product_details.dart';
import 'components/product_images.dart';
import 'components/similar_section.dart';
import 'components/top_header.dart';

class DetailScreen extends StatelessWidget {
  final Product product;
  final bool isBannerProduct;

  DetailScreen({required this.product, this.isBannerProduct = false});

  final DetailScreenController detailScreenController =
      Get.put(DetailScreenController());
  final CartScreenController cartScreenController = Get.find();
  final HomeScreenController homeScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return DraggableDetail(
      controller: detailScreenController,
      curvedBodyRadius: 0,
      headerExpandedHeight: 0.5,
      title: TopHeader(
        isBannerProduct: isBannerProduct,
        productId: product.id,
      ),
      headerWidget: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 45, right: 12, left: 10),
          child: Column(
            children: [
              TopHeader(
                isBannerProduct: isBannerProduct,
                productId: product.id,
              ),
              const SizedBox(height: 10),
              ProductImages(
                controller: detailScreenController,
                images: product.images,
                thumbnail: product.thumbnail,
              ),
            ],
          ),
        ),
      ),
      body: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductDetails(
                controller: detailScreenController,
                product: product,
              ),
              const SizedBox(height: 15),
              const Text(
                'Similar Products',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SimilarSection(
                categoryId: product.category.id,
                currentId: product.id,
                homeScreenController: homeScreenController,
                detailScreenController: detailScreenController,
              ),
            ],
          ),
        ),
      ],
      bottomNavigationBar: Obx(
        () => AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          height: detailScreenController.isAddCartVisible.value
              ? GetPlatform.isIOS
                  ? Get.height * 0.12
                  : Get.height * 0.08
              : 0.0,
          margin: detailScreenController.isAddCartVisible.value
              ? const EdgeInsets.only(right: 20, left: 20, bottom: 10)
              : const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: getStorage.read('isLogin') == true
                    ? () async {
                        await Get.to(
                          () => CartScreen(),
                        );
                      }
                    : () async {
                        await Get.to(
                          () => RegisterScreen(),
                        );
                      },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: customYellow,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Badge(
                    badgeContent: getStorage.read('isLogin') == true
                        ? Obx(
                            () => Text(
                              homeScreenController.cartLength.value.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                  fontSize: 12),
                            ),
                          )
                        : const Text(
                            '0',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                                fontSize: 12),
                          ),
                    badgeColor: Colors.white,
                    position: BadgePosition.topEnd(top: 5, end: 5),
                    child: SvgPicture.asset(
                      'assets/images/Bag.svg',
                      height: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              CustomButton(
                height: 50,
                width: Get.width * 0.5,
                text: 'Add to Cart',
                color: darkBlue,
                onPressed: () {
                  cartScreenController.addToCart(product);
                  homeScreenController.cartLength += 1;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

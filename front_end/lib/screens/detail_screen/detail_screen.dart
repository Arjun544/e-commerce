import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../controllers/home_screen_controller.dart';
import 'components/similar_scetion.dart';
import '../../controllers/cart_screen_controller.dart';
import '../../models/product_Model.dart';
import '../cart_screen/cart_screen.dart';
import '../register_screen/register_screen.dart';
import '../../utils/constants.dart';
import 'package:get/get.dart';

import '../../controllers/detail_screen_controller.dart';
import '../../utils/colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/draggable_home.dart';
import 'components/product_details.dart';
import 'components/product_images.dart';
import 'components/top_header.dart';

class DetailScreen extends StatelessWidget {
  final Product product;

  DetailScreen({required this.product});

  final DetailScreenController detailScreenController = Get.find();
  final CartScreenController cartScreenController = Get.find();
  final HomeScreenController homeScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      curvedBodyRadius: 0,
      headerExpandedHeight: 0.5,
      title: TopHeader(
        productId: product.id,
      ),
      headerWidget: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 45, right: 12, left: 10),
          child: Column(
            children: [
              TopHeader(
                productId: product.id,
              ),
              const SizedBox(height: 10),
              ProductImages(
                controller: detailScreenController,
                images: product.images,
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10),
        child: getStorage.read('isLogin') == true
            ? StreamBuilder<DocumentSnapshot>(
                stream: firebaseFirestore
                    .collection('carts')
                    .doc(cartScreenController.currentUserId.value)
                    .snapshots(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  var data;
                  if (snapshot.data!.data() != null) {
                    data = snapshot.data!.data();
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          getStorage.read('isLogin') == false
                              ? Get.to(
                                  () => RegisterScreen(),
                                )
                              : await Get.to(
                                  () => CartScreen(),
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
                            badgeContent: Text(
                              data['productIds'] == null
                                  ? '0'
                                  : data['productIds'].length.toString(),
                              style: const TextStyle(
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
                      data['productIds'].contains(product.id)
                          ? CustomButton(
                              height: 50,
                              width: Get.width * 0.5,
                              text: 'Added',
                              color: darkBlue,
                              onPressed: () {},
                            )
                          : CustomButton(
                              height: 50,
                              width: Get.width * 0.5,
                              text: 'Add to Cart',
                              color: darkBlue,
                              onPressed: () async {
                                await cartScreenController.addToCart(
                                  productId: product.id,
                                );
                              },
                            ),
                    ],
                  );
                })
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async {
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
                        badgeContent: const Text(
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
                    onPressed: () async {
                      await Get.to(() => RegisterScreen());
                    },
                  ),
                ],
              ),
      ),
    );
  }
}

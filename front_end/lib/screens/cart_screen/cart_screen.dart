import 'dart:developer';

import 'package:awesome_dropdown/awesome_dropdown.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front_end/models/cart_model.dart';
import 'package:front_end/screens/cart_screen/components/drop_menu.dart';
import 'package:front_end/screens/cart_screen/components/grand_total.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/cart_screen_controller.dart';
import '../../utils/colors.dart';
import '../../widgets/social_btn.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartScreenController cartScreenController =
      Get.put(CartScreenController());

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      cartScreenController.getCart();
      cartScreenController.cartSocketInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    right: 15, left: 15, top: 50, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: SvgPicture.asset(
                        'assets/images/Arrow - Left.svg',
                        height: 25,
                        color: darkBlue.withOpacity(0.7),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'My Cart',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Clear',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // cartScreenController.cartList.isEmpty
              //     ? Padding(
              //         padding: const EdgeInsets.only(top: 80),
              //         child: Column(
              //           children: [
              //             Lottie.asset('assets/empty.json',
              //                 height: Get.height * 0.3),
              //             const Text(
              //               'Nothing in cart',
              //               style: TextStyle(
              //                   fontWeight: FontWeight.bold,
              //                   fontSize: 20,
              //                   color: Colors.black45),
              //             ),
              //           ],
              //         ),
              //       )
              //     :
              Expanded(
                child: Obx(
                  () => ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: cartScreenController.cartProducts.length,
                      padding: const EdgeInsets.only(
                          right: 15, left: 15, bottom: 80),
                      itemBuilder: (context, index) {
                        return CartWidget(
                          cartScreenController: cartScreenController,
                          products: cartScreenController
                              .cartProducts[index].cartItems,
                        );
                      }),
                ),
              ),
            ],
          ),
          Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            margin: const EdgeInsets.only(right: 20, left: 20, bottom: 10),
            decoration: BoxDecoration(
              color: darkBlue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TotalGrand(
                  cartScreenController: cartScreenController,
                ),
                SocialButton(
                  height: 45,
                  width: Get.width * 0.4,
                  text: 'Continue',
                  icon: 'assets/images/Logout.svg',
                  color: Colors.grey.withOpacity(0.5),
                  iconColor: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CartWidget extends StatelessWidget {
  final List<CartItem> products;
  final CartScreenController cartScreenController;

  const CartWidget(
      {required this.products, required this.cartScreenController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.15,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: customGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: products.map((item) {
          cartScreenController.socket
              .emit('updatedCart', 'product_${item.product.id}');
          return Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: item.product.image,
                        fit: BoxFit.cover,
                        width: Get.width * 0.2,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.product.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          '\$ ${item.product.price.toString()}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 60,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropDown(
                        cartScreenController: cartScreenController,
                        item: item,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ignore: must_be_immutable
// class ItemQuantityCounter extends StatelessWidget {
//   final CartItem product;

//   ItemQuantityCounter({required this.product});
//   final CartScreenController cartScreenController =
//       Get.put(CartScreenController());
//   @override
//   Widget build(BuildContext context) {
//     cartScreenController.productQuantity.value = product.quantity;
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         GestureDetector(
//           onTap: () async {
//             await cartScreenController.decrementQuantity(productId: product.id);
//             cartScreenController.socket.on('updatedCart', (data) {
//               cartScreenController.productQuantity.value = data['quantity'];
//               cartScreenController.grandPrice.value = data['totalGrand'];
//             });
//           },
//           child: Container(
//             height: 25,
//             width: 25,
//             alignment: Alignment.center,
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(
//               Icons.remove_rounded,
//               size: 20,
//             ),
//           ),
//         ),
//         const SizedBox(
//           height: 5,
//         ),
//         Obx(() => Text(
//               cartScreenController.productQuantity.value.toString(),
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//             )),
//         const SizedBox(
//           height: 5,
//         ),
//         GestureDetector(
//           onTap: () async {
//             await cartScreenController.incrementQuantity(productId: product.id);
//             cartScreenController.socket.on('updatedCart', (data) {
//               cartScreenController.productQuantity.value = data['quantity'];
//               cartScreenController.grandPrice.value = data['totalGrand'];
//             });
//           },
//           child: Container(
//             height: 25,
//             width: 25,
//             alignment: Alignment.center,
//             decoration: const BoxDecoration(
//               color: customYellow,
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(Icons.add_rounded, size: 20),
//           ),
//         ),
//       ],
//     );
//   }
// }

// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:lottie/lottie.dart';
// import '../controllers/cart_screen_controller.dart';
// import '../models/product_Model.dart';
// import '../widgets/social_btn.dart';
// import '../utils/colors.dart';
// import 'package:get/get.dart';

// class CartScreen extends StatelessWidget {
//   final CartScreenController cartScreenController =
//       Get.put(CartScreenController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         alignment: Alignment.bottomCenter,
//         children: [
//           Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(
//                     right: 15, left: 15, top: 50, bottom: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     GestureDetector(
//                       onTap: () => Get.back(),
//                       child: SvgPicture.asset(
//                         'assets/images/Arrow - Left.svg',
//                         height: 25,
//                         color: darkBlue.withOpacity(0.7),
//                       ),
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.only(left: 10),
//                       child: Text(
//                         'My Cart',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 20),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {},
//                       child: const Text(
//                         'Clear',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                           color: Colors.redAccent,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               // NList is empty widget
//               // Padding(
//               //             padding: const EdgeInsets.only(top: 80),
//               //             child: Column(
//               //               children: [
//               //                 Lottie.asset('assets/empty.json',
//               //                     height: Get.height * 0.3),
//               //                 const Text(
//               //                   'Nothing in cart',
//               //                   style: TextStyle(
//               //                       fontWeight: FontWeight.bold,
//               //                       fontSize: 20,
//               //                       color: Colors.black45),
//               //                 ),
//               //               ],
//               //             ),
//               //           )
//               Expanded(
//                 child: ListView.builder(
//                     shrinkWrap: true,
//                     scrollDirection: Axis.vertical,
//                     itemCount: 2,
//                     padding:
//                         const EdgeInsets.only(right: 15, left: 15, bottom: 80),
//                     itemBuilder: (context, index) {
//                       return CartItem(
//                         product: cartScreenController.cartList[index],
//                       );
//                     }),
//               ),
//             ],
//           ),
//           cartScreenController.cartList.isEmpty
//               ? const SizedBox.shrink()
//               : Container(
//                   height: 70,
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   margin:
//                       const EdgeInsets.only(right: 20, left: 20, bottom: 10),
//                   decoration: BoxDecoration(
//                     color: darkBlue,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Obx(
//                         () => Text(
//                           '\$ ${cartScreenController.totalPrice.value.toString()}',
//                           style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20,
//                               color: Colors.white),
//                         ),
//                       ),
//                       SocialButton(
//                         height: 45,
//                         width: Get.width * 0.4,
//                         text: 'Continue',
//                         icon: 'assets/images/Logout.svg',
//                         color: Colors.grey.withOpacity(0.5),
//                         iconColor: Colors.white,
//                       ),
//                     ],
//                   ),
//                 ),
//         ],
//       ),
//     );
//   }
// }

// class CartItem extends StatelessWidget {
//   final ProductModel product;

//   const CartItem({required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: Get.height * 0.15,
//       margin: const EdgeInsets.only(bottom: 10),
//       padding: const EdgeInsets.symmetric(horizontal: 15),
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         color: customGrey,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: Image.asset(
//                   'assets/arjun profile.jpg',
//                   height: 60,
//                 ),
//               ),
//               const SizedBox(
//                 width: 15,
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     product.name,
//                     style: const TextStyle(
//                         fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                   Text(
//                     '\$ ${product.price.toString()}',
//                     style: const TextStyle(
//                         fontWeight: FontWeight.bold, fontSize: 12),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           ItemQuantityCounter(
//             product: product,
//           )
//         ],
//       ),
//     );
//   }
// }

// // ignore: must_be_immutable
// class ItemQuantityCounter extends StatefulWidget {
//   final ProductModel product;

//   ItemQuantityCounter({required this.product});
//   final CartScreenController cartScreenController =
//       Get.put(CartScreenController());

//   @override
//   _ItemQuantityCounterState createState() => _ItemQuantityCounterState();
// }

// class _ItemQuantityCounterState extends State<ItemQuantityCounter> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         GestureDetector(
//           onTap: () {
//             setState(() {
//               if (widget.product.quantity! > 1) {
//                 widget.product.quantity = widget.product.quantity! - 1;
//                 widget.cartScreenController
//                     .updateTotalPrice(widget.product.price);
//               }
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
//         Text(
//           widget.product.quantity.toString(),
//           style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//         ),
//         const SizedBox(
//           height: 5,
//         ),
//         GestureDetector(
//           onTap: () {
//             setState(() {
//               widget.product.quantity = widget.product.quantity! + 1;
//             });
//             widget.cartScreenController
//                 .calculateTotalPrice(widget.product.price);
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

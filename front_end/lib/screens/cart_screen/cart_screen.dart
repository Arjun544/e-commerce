import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:front_end/controllers/checkout_screen_controller.dart';
import 'package:front_end/screens/checkout_screen/checkout_screen.dart';
import '../../widgets/loaders/cart_screen_loader.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/cart_screen_controller.dart';
import '../../controllers/home_screen_controller.dart';
import '../../models/cart_model.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../widgets/social_btn.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartScreenController cartScreenController = Get.find();
  final HomeScreenController homeScreenController = Get.find();
  final CheckoutScreenController checkoutScreenController =
      Get.put(CheckoutScreenController());

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      cartScreenController.cartSocketInit();
      cartScreenController.getCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: cartScreenController.cartProductsStreamController.stream,
          builder: (context, AsyncSnapshot<CartModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CartScreenLoader();
            }
            cartScreenController.cartProductsLength.value =
                snapshot.data!.cartList.length;
            cartScreenController.cartTotal.add(snapshot.data!.totalGrand);
            return Stack(
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
                            onTap: () => Get.back(closeOverlays: true),
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
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                          snapshot.data!.cartList.isEmpty
                              ? const SizedBox(
                                  width: 15,
                                )
                              : GestureDetector(
                                  onTap: () async {
                                    await cartScreenController.clearCart(
                                        userId: getStorage.read('userId'));

                                    setState(() {
                                      cartScreenController.getCart();
                                    });
                                  },
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
                    snapshot.data!.cartList.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 80),
                            child: Column(
                              children: [
                                Lottie.asset('assets/empty.json',
                                    height: Get.height * 0.3),
                                const Text(
                                  'Nothing in cart',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.black45),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.cartList.length,
                            padding: const EdgeInsets.only(
                                right: 15, left: 15, bottom: 80),
                            itemBuilder: (context, index) {
                              return SwipeActionCell(
                                key: ValueKey(snapshot.data!.cartList[index]),
                                performsFirstActionWithFullSwipe: true,
                                trailingActions: <SwipeAction>[
                                  SwipeAction(
                                    title: 'Remove',
                                    widthSpace: 100,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    onTap: (CompletionHandler handler) async {
                                      handler(false);

                                      await cartScreenController.deleteItem(
                                        id: snapshot.data!.cartList[index].id,
                                      );
                                      await firebaseFirestore
                                          .collection('carts')
                                          .doc(getStorage.read('userId'))
                                          .update({
                                        'productIds': FieldValue.arrayRemove([
                                          cartScreenController.productIds[index]
                                        ])
                                      });
                                      setState(() {
                                        cartScreenController.getCart();
                                      });
                                    },
                                    color: Colors.red,
                                    backgroundRadius: 20,
                                  ),
                                ],
                                child: CartWidget(
                                  cartScreenController: cartScreenController,
                                  checkoutScreenController:
                                      checkoutScreenController,
                                  products:
                                      snapshot.data!.cartList[index].cartItems,
                                ),
                              );
                            }),
                  ],
                ),
                snapshot.data!.cartList.isEmpty
                    ? const SizedBox.shrink()
                    : Container(
                        height: 70,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.only(
                            right: 20, left: 20, bottom: 10),
                        decoration: BoxDecoration(
                          color: darkBlue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StreamBuilder(
                                stream: cartScreenController.cartTotal.stream,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const SizedBox();
                                  }

                                  return Text(
                                    '${snapshot.data.toString()}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white),
                                  );
                                }),
                            Obx(
                              () => SocialButton(
                                height: 45,
                                width: Get.width * 0.4,
                                text: 'Check out',
                                icon: 'assets/images/Logout.svg',
                                color: checkoutScreenController
                                        .orderItems.isNotEmpty
                                    ? customYellow
                                    : Colors.grey.withOpacity(0.5),
                                iconColor: Colors.white,
                                onPressed: () {
                                  checkoutScreenController.orderItems.isNotEmpty
                                      ? Get.to(
                                          () => CheckoutScreen(),
                                        )
                                      : EasyLoading.showToast(
                                          'Select items to check out',
                                          toastPosition:
                                              EasyLoadingToastPosition.top,
                                          maskType: EasyLoadingMaskType.clear,
                                        );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            );
          }),
    );
  }
}

class CartWidget extends StatefulWidget {
  final List<CartItem> products;
  final CartScreenController cartScreenController;
  final CheckoutScreenController checkoutScreenController;

  const CartWidget(
      {required this.products,
      required this.cartScreenController,
      required this.checkoutScreenController});

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.products.map((item) {
        widget.cartScreenController.productIds.add(item.product.id);
        widget.cartScreenController.socket
            .emit('updatedCart', 'product_${item.product.id}');
        return Row(
          children: [
            Obx(
              () => Checkbox(
                activeColor: customYellow,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                value: widget.checkoutScreenController.orderItems.contains(item)
                    ? true
                    : false,
                onChanged: (value) {
                  value == true
                      ? widget.checkoutScreenController.orderItems.add(item)
                      : widget.checkoutScreenController.orderItems.remove(item);

                  log(widget.checkoutScreenController.orderItems
                      .map((element) => element.quantity)
                      .toString());
                },
              ),
            ),
            Expanded(
              child: Container(
                height: Get.height * 0.15,
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.only(right: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: customGrey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
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
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.product.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  item.product.discount > 0
                                      ? Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '\$${item.product.totalPrice.toString()}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              '\$${item.product.price.toString()}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                decorationColor: Colors.red,
                                                decorationThickness: 3,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: Colors.black45,
                                              ),
                                            ),
                                          ],
                                        )
                                      : Text(
                                          '\$${item.product.price.toString()}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13),
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
                                child: DropdownButtonHideUnderline(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 14.0, right: 6),
                                    child: DropdownButton<int>(
                                      value: item.quantity,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87),
                                      isExpanded: true,
                                      iconEnabledColor: Colors.black,
                                      items:
                                          <int>[1, 2, 3, 4, 5].map((int value) {
                                        return DropdownMenuItem<int>(
                                          value: value,
                                          child: Text(value.toString()),
                                        );
                                      }).toList(),
                                      onChanged: (value) async {
                                        widget.cartScreenController.socket
                                            .on('updatedCart', (data) {
                                          item.quantity = data['quantity'];
                                          widget.cartScreenController.cartTotal
                                              .add(data['totalGrand']);
                                          item.quantity = value!;
                                        });
                                        await widget.cartScreenController
                                            .updateQuantity(
                                          productId: item.id,
                                          newQuantity: value!,
                                        );

                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}

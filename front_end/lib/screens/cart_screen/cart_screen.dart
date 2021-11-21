import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import '../checkout_screen/checkout_screen.dart';
import '../../widgets/loaders/cart_screen_loader.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/cart_screen_controller.dart';
import '../../controllers/home_screen_controller.dart';
import '../../models/cart_model.dart';
import '../../utils/colors.dart';
import '../../widgets/social_btn.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartScreenController cartScreenController = Get.find();
  final HomeScreenController homeScreenController = Get.find();

  @override
  void initState() {
    super.initState();
    cartScreenController.getCart();
    cartScreenController.orderItems.clear();
    cartScreenController.isOrderItemsSelected.value = false;
  }

  Future<bool> _backPressed() async {
    cartScreenController.orderItems.clear();
    cartScreenController.isOrderItemsSelected.value = false;
    return Future<bool>.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _backPressed(),
      child: Scaffold(
        body: Obx(
          () => cartScreenController.isLoading.value
              ? CartScreenLoader()
              : Stack(
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
                                onTap: () {
                                  Get.back(closeOverlays: true);
                                  cartScreenController.orderItems.clear();
                                  cartScreenController
                                      .isOrderItemsSelected.value = false;
                                },
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              cartScreenController
                                      .cartProducts.value.products.isEmpty
                                  ? const SizedBox(
                                      width: 15,
                                    )
                                  : GestureDetector(
                                      onTap: () async {
                                        await EasyLoading.show(
                                            status: 'Clearing...',
                                            dismissOnTap: false);
                                        await cartScreenController.clearCart();
                                        await EasyLoading.dismiss();

                                        await EasyLoading.showToast(
                                          'Cart cleared',
                                          toastPosition:
                                              EasyLoadingToastPosition.top,
                                          maskType: EasyLoadingMaskType.clear,
                                        );

                                        cartScreenController.getCart();
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
                        cartScreenController.cartProducts.value.products.isEmpty
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
                                itemCount: cartScreenController
                                    .cartProducts.value.products.length,
                                padding: const EdgeInsets.only(
                                    right: 15, left: 15, bottom: 80),
                                itemBuilder: (context, index) {
                                  var products = cartScreenController
                                      .cartProducts.value.products;
                                  RxList total = [].obs;
                                  total.add(products
                                      .map((e) => e.discount > 0
                                          ? e.totalPrice
                                          : e.price * e.quantity)
                                      .toList());
                                  cartScreenController.cartTotal
                                      .add(total[0].fold(0, (p, c) => p + c));

                                  RxInt currentQuantity = 0.obs;
                                  currentQuantity.value =
                                      products[index].quantity;
                                  return SwipeActionCell(
                                    key: ValueKey(products[index]),
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
                                        onTap:
                                            (CompletionHandler handler) async {
                                          handler(false);

                                          await cartScreenController.deleteItem(
                                            id: cartScreenController
                                                .cartProducts.value.id,
                                            productId: products[index].id,
                                          );
                                          cartScreenController.getCart();
                                        },
                                        color: Colors.red,
                                        backgroundRadius: 20,
                                      ),
                                    ],
                                    child: CartWidget(
                                      cartScreenController:
                                          cartScreenController,
                                      homeScreenController:
                                          homeScreenController,
                                      product: products[index],
                                    ),
                                  );
                                }),
                      ],
                    ),
                    cartScreenController.cartProducts.value.products.isEmpty
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
                                    stream:
                                        cartScreenController.cartTotal.stream,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const SizedBox();
                                      }

                                      return Obx(
                                        () => Text(
                                          cartScreenController
                                                  .isOrderItemsSelected.value
                                              ? '${cartScreenController.orderItemsTotal.value.toString()}'
                                              : '${snapshot.data.toString()}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      );
                                    }),
                                Obx(
                                  () => SocialButton(
                                    height: 45,
                                    width: Get.width * 0.4,
                                    text: 'Check out',
                                    icon: 'assets/images/Logout.svg',
                                    color: cartScreenController
                                            .orderItems.isNotEmpty
                                        ? customYellow
                                        : Colors.grey.withOpacity(0.5),
                                    iconColor: Colors.white,
                                    onPressed: () {
                                      cartScreenController.orderItems.isNotEmpty
                                          ? Get.to(
                                              () => CheckoutScreen(),
                                            )
                                          : EasyLoading.showToast(
                                              'Select items to check out',
                                              toastPosition:
                                                  EasyLoadingToastPosition.top,
                                              maskType:
                                                  EasyLoadingMaskType.clear,
                                            );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
        ),
      ),
    );
  }
}

class CartWidget extends StatefulWidget {
  final CartProduct product;
  final CartScreenController cartScreenController;
  final HomeScreenController homeScreenController;

  const CartWidget({
    required this.product,
    required this.cartScreenController,
    required this.homeScreenController,
  });

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  void initState() {
    widget.homeScreenController.socket
        .emit('updatedCart', 'product_${widget.product.id}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          Obx(
            () => Checkbox(
              activeColor: customYellow,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              value: widget.cartScreenController.orderItems
                      .contains(widget.product)
                  ? true
                  : false,
              onChanged: (value) {
                RxList total = [].obs;

                if (value == true) {
                  widget.cartScreenController.orderItems.add(widget.product);
                  widget.cartScreenController.isOrderItemsSelected.value = true;
                } else {
                  widget.cartScreenController.orderItems.remove(widget.product);
                  if (widget.cartScreenController.orderItems.isEmpty) {
                    widget.cartScreenController.isOrderItemsSelected.value =
                        false;
                  }
                }
                total.add(widget.cartScreenController.orderItems
                    .map((e) =>
                        e.discount > 0 ? e.totalPrice : e.price * e.quantity)
                    .toList());
                widget.cartScreenController.orderItemsTotal.value =
                    total[0].fold(0, (p, c) => p + c);
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
                            const SizedBox(width: 10),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                imageUrl: widget.product.thumbnail,
                                fit: BoxFit.cover,
                                width: Get.width * 0.14,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.product.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                widget.product.discount > 0
                                    ? Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '\$${widget.product.totalPrice.toString()}',
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
                                            '\$${widget.product.price.toString()}',
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
                                        '\$${widget.product.price.toString()}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                      ),
                                const SizedBox(
                                  height: 10,
                                ),
                                widget.product.discount > 0
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            '${widget.product.discount}%',
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            'OFF',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      )
                                    : const SizedBox.shrink(),
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
                                    value: widget.product.quantity,
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
                                      await widget.cartScreenController
                                          .updateQuantity(
                                        productId: widget.product.id,
                                        value: value!,
                                      );

                                      widget.homeScreenController.socket
                                          .on('updatedCart', (data) {
                                        widget.product.quantity = int.parse(
                                            data['quantity'].toString());
                                        widget.cartScreenController.cartTotal
                                            .add(data['totalGrand']);
                                      });
                                      widget.cartScreenController
                                          .isOrderItemsSelected.value = false;
                                      widget.cartScreenController.orderItems
                                          .clear();
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
      ),
    ]);
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/cart_screen_controller.dart';
import '../../controllers/home_screen_controller.dart';
import '../../models/cart_model.dart';
import '../../utils/colors.dart';
import '../../widgets/loaders/cart_screen_loader.dart';
import 'components/QuantityDropDown.dart';
import 'components/TotalCounter.dart';

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
    cartScreenController.getCart().then((_) {
      var products = cartScreenController.cartProducts.value.products;
      RxList total = [].obs;
      total.add(products
          .map((e) =>
              e.discount > 0 ? e.totalPrice * e.quantity : e.price * e.quantity)
          .toList());
      cartScreenController.cartTotal.value = total[0].fold(0, (p, c) => p + c);
    });

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
                              right: 15, left: 15, top: 40, bottom: 20),
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
                                        homeScreenController.cartLength.value =
                                            0;
                                        await cartScreenController.getCart();
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
                                    right: 15, bottom: 80),
                                itemBuilder: (context, index) {
                                  // calc total price
                                  var products = cartScreenController
                                      .cartProducts.value.products;

                                  RxInt currentQuantity = 0.obs;
                                  currentQuantity.value =
                                      products[index].quantity;
                                  return SwipeActionCell(
                                    key: ValueKey(products[index]),
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
                                          homeScreenController
                                              .cartLength.value -= 1;
                                          await cartScreenController.getCart();
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
                    TotalCounter(cartScreenController: cartScreenController),
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
                    .map((e) => e.discount > 0
                        ? e.totalPrice * e.quantity
                        : e.price * e.quantity)
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
                      children: [
                        const SizedBox(width: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: widget.product.thumbnail,
                            fit: BoxFit.contain,
                            width: Get.width * 0.14,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: Get.width * 0.6,
                                child: Text(
                                  widget.product.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  widget.product.discount > 0
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
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
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    color: Colors.black45,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            widget.product.discount > 0
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        '${widget.product.discount}%',
                                                        style: const TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : const SizedBox.shrink(),
                                          ],
                                        )
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(top: 12.0),
                                          child: Text(
                                            '\$${widget.product.price.toString()}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13),
                                          ),
                                        ),
                                  QuantityDropDown(
                                      cartScreenController:
                                          widget.cartScreenController,
                                      item: widget.product),
                                ],
                              ),
                            ],
                          ),
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

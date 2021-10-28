import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import '../controllers/profile_screen_controller.dart';
import '../controllers/root_screen_controller.dart';
import '../models/userModel.dart';
import '../screens/profile_screen/components/add_ship_address.dart';
import '../utils/colors.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'delete_confirm.dart';

class AddressWidget extends StatefulWidget {
  final bool isOrdering;
  final UserModel? currentUser;

  const AddressWidget({required this.currentUser, required this.isOrdering});
  @override
  _AddressWidgetState createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  final ProfileScreenController profileScreenController = Get.find();
  final RootScreenController rootScreenController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Addresses',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        widget.currentUser!.data.shippingAddress.isEmpty
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: Get.height * 0.2),
                child: const Center(
                  child: Text(
                    'No Address',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.grey),
                  ),
                ),
              )
            : ListView.builder(
                itemCount: widget.currentUser!.data.shippingAddress.length,
                shrinkWrap: true,
                padding: widget.isOrdering
                    ? const EdgeInsets.symmetric(vertical: 10)
                    : const EdgeInsets.symmetric(vertical: 20),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      profileScreenController.selectedShippingAddress.value =
                          index;
                    },
                    child: Obx(
                      () => Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            height: widget.isOrdering
                                ? Get.height * 0.16
                                : Get.height * 0.17,
                            width: Get.width,
                            margin: const EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                              color: customGrey,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            widget
                                                        .currentUser!
                                                        .data
                                                        .shippingAddress[index]
                                                        .type ==
                                                    'Home'
                                                ? 'assets/images/Home.svg'
                                                : 'assets/images/Work.svg',
                                            height: 20,
                                            color: darkBlue,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            toBeginningOfSentenceCase(
                                                  widget
                                                      .currentUser!
                                                      .data
                                                      .shippingAddress[index]
                                                      .type,
                                                ) ??
                                                '',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                      widget.isOrdering
                                          ? const SizedBox.shrink()
                                          : Row(
                                              children: [
                                                InkWell(
                                                  onTap: () => Get.to(
                                                    () => AddShipAddress(
                                                      isEditing: true,
                                                      shipAddress: widget
                                                              .currentUser!
                                                              .data
                                                              .shippingAddress[
                                                          index],
                                                      profileScreenController:
                                                          profileScreenController,
                                                    ),
                                                  ),
                                                  child: SvgPicture.asset(
                                                    'assets/images/Pen.svg',
                                                    height: 17,
                                                    color: customYellow,
                                                  ),
                                                ),
                                                const SizedBox(width: 15),
                                                InkWell(
                                                  onTap: () async {
                                                    DeleteDialogue(
                                                      context,
                                                      () async {
                                                        await profileScreenController
                                                            .removeAddress(
                                                          address: widget
                                                              .currentUser!
                                                              .data
                                                              .shippingAddress[
                                                                  index]
                                                              .address,
                                                          city: widget
                                                              .currentUser!
                                                              .data
                                                              .shippingAddress[
                                                                  index]
                                                              .city,
                                                          country: widget
                                                              .currentUser!
                                                              .data
                                                              .shippingAddress[
                                                                  index]
                                                              .country,
                                                          phone: widget
                                                              .currentUser!
                                                              .data
                                                              .shippingAddress[
                                                                  index]
                                                              .phone,
                                                          type: widget
                                                              .currentUser!
                                                              .data
                                                              .shippingAddress[
                                                                  index]
                                                              .type,
                                                        );
                                                        await EasyLoading.show(
                                                            status:
                                                                'loading...',
                                                            dismissOnTap:
                                                                false);
                                                        Get.back();
                                                        setState(() {
                                                          rootScreenController
                                                              .getCurrentUser();
                                                        });
                                                        await EasyLoading
                                                            .dismiss();
                                                      },
                                                    );
                                                  },
                                                  child: SvgPicture.asset(
                                                    'assets/images/Delete.svg',
                                                    height: 20,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        toBeginningOfSentenceCase(
                                              widget
                                                  .currentUser!
                                                  .data
                                                  .shippingAddress[index]
                                                  .address,
                                            ) ??
                                            '',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        toBeginningOfSentenceCase(
                                              widget
                                                      .currentUser!
                                                      .data
                                                      .shippingAddress[index]
                                                      .city +
                                                  ', ' +
                                                  widget
                                                      .currentUser!
                                                      .data
                                                      .shippingAddress[index]
                                                      .country,
                                            ) ??
                                            '',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    widget.currentUser!.data
                                        .shippingAddress[index].phone,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          profileScreenController
                                      .selectedShippingAddress.value ==
                                  index
                              ? Positioned(
                                  bottom: 15,
                                  right: 0,
                                  child: Container(
                                    height: 30,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[400],
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(40),
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.check_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  );
                }),
      ],
    );
  }
}

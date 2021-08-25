import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'add_ship_address.dart';
import '../../../widgets/delete_confirm.dart';
import 'package:intl/intl.dart';
import '../../../controllers/profile_screen_controller.dart';
import '../../../controllers/root_screen_controller.dart';
import '../../../models/userModel.dart';
import 'top_header.dart';
import '../../../utils/colors.dart';
import 'package:get/get.dart';

class ShippingAddress extends StatefulWidget {
  @override
  _ShippingAddressState createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  final ProfileScreenController profileScreenController = Get.find();

  final RootScreenController rootScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 40),
        child: const TopHeader(text: 'Shipping Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: StreamBuilder<UserModel>(
            stream: rootScreenController.currentUserStreamController.stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox();
              } else if (snapshot.data == null) {}
              UserModel? currentUser = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  DottedBorder(
                    color: Colors.black,
                    dashPattern: [10, 10],
                    strokeWidth: 2,
                    strokeCap: StrokeCap.round,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(20),
                    child: InkWell(
                      onTap: () => Get.to(
                        () => AddShipAddress(
                          isEditing: false,
                          profileScreenController: profileScreenController,
                        ),
                      ),
                      child: Container(
                        height: Get.height * 0.1,
                        width: Get.width,
                        alignment: Alignment.center,
                        child: const Text(
                          'Add Address',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Address',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  currentUser!.data.shippingAddress.isEmpty
                      ? Padding(
                          padding: EdgeInsets.only(top: Get.height * 0.2),
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
                      : Expanded(
                          child: ListView.builder(
                              itemCount:
                                  currentUser.data.shippingAddress.length,
                              shrinkWrap: true,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    profileScreenController
                                        .selectedShippingAddress.value = index;
                                  },
                                  child: Obx(
                                    () => Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        Container(
                                          height: Get.height * 0.17,
                                          width: Get.width,
                                          margin:
                                              const EdgeInsets.only(bottom: 15),
                                          decoration: BoxDecoration(
                                            color: customGrey,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          currentUser
                                                                      .data
                                                                      .shippingAddress[
                                                                          index]
                                                                      .type ==
                                                                  'Home'
                                                              ? 'assets/images/Home.svg'
                                                              : 'assets/images/Work.svg',
                                                          height: 20,
                                                          color: darkBlue,
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        Text(
                                                          toBeginningOfSentenceCase(
                                                                currentUser
                                                                    .data
                                                                    .shippingAddress[
                                                                        index]
                                                                    .type,
                                                              ) ??
                                                              '',
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () => Get.to(
                                                            () =>
                                                                AddShipAddress(
                                                              isEditing: true,
                                                              shipAddress:
                                                                  currentUser
                                                                          .data
                                                                          .shippingAddress[
                                                                      index],
                                                              profileScreenController:
                                                                  profileScreenController,
                                                            ),
                                                          ),
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/images/Pen.svg',
                                                            height: 17,
                                                            color: customYellow,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 15),
                                                        InkWell(
                                                          onTap: () async {
                                                            DeleteDialogue(
                                                              context,
                                                              () async {
                                                                await profileScreenController
                                                                    .removeAddress(
                                                                  address: currentUser
                                                                      .data
                                                                      .shippingAddress[
                                                                          index]
                                                                      .address,
                                                                  city: currentUser
                                                                      .data
                                                                      .shippingAddress[
                                                                          index]
                                                                      .city,
                                                                  country: currentUser
                                                                      .data
                                                                      .shippingAddress[
                                                                          index]
                                                                      .country,
                                                                  phone: currentUser
                                                                      .data
                                                                      .shippingAddress[
                                                                          index]
                                                                      .phone,
                                                                  type: currentUser
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
                                                          child:
                                                              SvgPicture.asset(
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
                                                            currentUser
                                                                .data
                                                                .shippingAddress[
                                                                    index]
                                                                .address,
                                                          ) ??
                                                          '',
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Text(
                                                      toBeginningOfSentenceCase(
                                                            currentUser
                                                                    .data
                                                                    .shippingAddress[
                                                                        index]
                                                                    .city +
                                                                ', ' +
                                                                currentUser
                                                                    .data
                                                                    .shippingAddress[
                                                                        index]
                                                                    .country,
                                                          ) ??
                                                          '',
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  currentUser
                                                      .data
                                                      .shippingAddress[index]
                                                      .phone,
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
                                                    .selectedShippingAddress
                                                    .value ==
                                                index
                                            ? Positioned(
                                                bottom: 15,
                                                right: 0,
                                                child: Container(
                                                  height: 30,
                                                  width: 45,
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue[400],
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(30),
                                                      bottomRight:
                                                          Radius.circular(40),
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
                        ),
                ],
              );
            }),
      ),
    );
  }
}

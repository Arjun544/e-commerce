import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front_end/widgets/address_widget.dart';
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
                      onTap: currentUser!.data.shippingAddress.length == 3
                          ? () => EasyLoading.showToast(
                                "Only 3 addresses can't added",
                                toastPosition: EasyLoadingToastPosition.top,
                                maskType: EasyLoadingMaskType.clear,
                              )
                          : () => Get.to(
                                () => AddShipAddress(
                                  isEditing: false,
                                  profileScreenController:
                                      profileScreenController,
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
                  AddressWidget(
                    currentUser: currentUser,
                    isOrdering: false,
                  ),
                ],
              );
            }),
      ),
    );
  }
}

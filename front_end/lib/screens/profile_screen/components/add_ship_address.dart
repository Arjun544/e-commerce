import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../controllers/profile_screen_controller.dart';
import '../../../controllers/root_screen_controller.dart';
import '../../../models/userModel.dart';
import '../../../utils/colors.dart';
import '../../../widgets/custom_button.dart';
import 'top_header.dart';

class AddShipAddress extends StatefulWidget {
  final bool isEditing;
  final ShipAddress? shipAddress;
  final ProfileScreenController profileScreenController;

  const AddShipAddress({
    Key? key,
    required this.profileScreenController,
    required this.isEditing,
    this.shipAddress,
  }) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<AddShipAddress> {
  final RootScreenController rootScreenController = Get.find();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  String phone = '+92xxx xxxxxxx';
  String country = 'Pakistan';
  String type = 'Home';

  int selectedButton = 0;

  @override
  void initState() {
    super.initState();
    if (widget.isEditing == true) {
      switch (widget.shipAddress!.type) {
        case 'home':
          selectedButton = 0;
          break;
        case 'work':
          selectedButton = 1;
          break;
        default:
      }
      addressController.text = widget.shipAddress!.address;
      cityController.text = widget.shipAddress!.city;
      phone = widget.shipAddress!.phone;
      type = widget.shipAddress!.type;
    }
  }

  @override
  void dispose() {
    addressController.clear();
    cityController.clear();
    addressController.dispose();
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40.0, left: 8, bottom: 6),
          child: TopHeader(
              text: widget.isEditing ? 'Edit Address' : 'Add Address'),
        ),
        const SizedBox(height: 20),
        GroupButton(
          spacing: 30,
          isRadio: true,
          buttonWidth: Get.width * 0.3,
          buttonHeight: Get.height * 0.05,
          direction: Axis.horizontal,
          onSelected: (index, isSelected) {
            switch (index) {
              case 0:
                type = 'home';
                break;
              case 1:
                type = 'work';
                break;
              default:
            }
          },
          buttons: [
            'Home',
            'Work',
          ],
          selectedButton: selectedButton,
          selectedTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
          unselectedTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black,
          ),
          selectedColor: Colors.blue,
          unselectedColor: Colors.transparent,
          selectedBorderColor: Colors.transparent,
          unselectedBorderColor: Colors.grey,
          borderRadius: BorderRadius.circular(10.0),
        ),
        const SizedBox(height: 10),
        Column(
          children: [
            customField(
              text: 'Address',
              controller: addressController,
              icon: 'assets/images/Home.svg',
            ),
            const SizedBox(height: 20),
            customField(
              text: 'City',
              controller: cityController,
              icon: 'assets/images/Location.svg',
            ),
            const SizedBox(height: 20),
            Container(
              height: 70,
              width: Get.width,
              padding: const EdgeInsets.only(left: 10),
              margin: const EdgeInsets.only(left: 15, right: 15),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  phone = number.phoneNumber!;
                },
                onInputValidated: (bool value) {},
                selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.DROPDOWN,
                ),
                ignoreBlank: true,
                autoValidateMode: AutovalidateMode.disabled,
                selectorTextStyle: const TextStyle(color: Colors.black),
                hintText: phone,
                initialValue: PhoneNumber(
                  phoneNumber: '+923xx xxxxxxx',
                  dialCode: '+92',
                  isoCode: 'PK',
                ),
                formatInput: true,
                keyboardType: const TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                inputBorder: InputBorder.none,
                onSaved: (PhoneNumber number) {
                  print('On Saved: $number');
                },
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 70,
              width: Get.width,
              padding: const EdgeInsets.only(left: 10),
              margin: const EdgeInsets.only(left: 15, right: 15),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: CountryCodePicker(
                onChanged: (value) {
                  country = value.name!;
                },
                initialSelection: 'PK',
                dialogTextStyle: const TextStyle(fontWeight: FontWeight.bold),
                showCountryOnly: false,
                showOnlyCountryWhenClosed: true,
                alignLeft: false,
                searchStyle: const TextStyle(fontWeight: FontWeight.bold),
                boxDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                searchDecoration: const InputDecoration(
                  hintText: 'Search country',
                  border: InputBorder.none,
                  filled: true,
                  fillColor: customGrey,
                ),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: Get.height * 0.1),
        Padding(
          padding: EdgeInsets.only(bottom: Get.height * 0.1),
          child: CustomButton(
            height: 60,
            width: Get.width * 0.8,
            text: widget.isEditing ? 'Edit' : 'Add',
            color: customYellow,
            onPressed: () async {
              if (addressController.text.isEmpty ||
                  cityController.text.isEmpty ||
                  phone.isEmpty) {
                await EasyLoading.showToast(
                  "Fields can't be empty",
                  toastPosition: EasyLoadingToastPosition.top,
                  maskType: EasyLoadingMaskType.clear,
                );
              } else {
                await widget.profileScreenController.addAddress(
                  address: addressController.text,
                  city: cityController.text,
                  phone: phone,
                  country: country,
                  type: type,
                );
                Get.back();
                await EasyLoading.show(
                    status: 'loading...', dismissOnTap: false);
                setState(() {
                  rootScreenController.getCurrentUser();
                });
                await EasyLoading.dismiss();
              }
            },
          ),
        ),
      ],
    );
  }
}

class customField extends StatelessWidget {
  final bool isNumerical;
  final String text;
  final String icon;
  final TextEditingController controller;

  customField({
    Key? key,
    required this.text,
    required this.controller,
    this.isNumerical = false,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 70,
        width: Get.width,
        padding: const EdgeInsets.only(left: 10, right: 10),
        margin: const EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              height: 25,
              color: darkBlue.withOpacity(0.4),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: controller,
                keyboardType:
                    isNumerical ? TextInputType.number : TextInputType.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: text,
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

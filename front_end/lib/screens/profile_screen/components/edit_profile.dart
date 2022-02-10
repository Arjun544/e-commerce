
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../controllers/profile_screen_controller.dart';
import '../../../models/userModel.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../widgets/custom_button.dart';
import 'top_header.dart';

class EditProfile extends StatefulWidget {
  final ProfileScreenController profileScreenController;
  final UserModel? currentUser;

  const EditProfile(
      {Key? key,
      required this.profileScreenController,
      required this.currentUser})
      : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final nameController = TextEditingController();
  final cityController = TextEditingController();
  final streetController = TextEditingController();
  final zipController = TextEditingController();
  String country = 'Pakistan';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      nameController.text = widget.currentUser!.data.username;
      cityController.text = widget.currentUser!.data.city;
      streetController.text = widget.currentUser!.data.street;
      zipController.text = widget.currentUser!.data.zip;
      country = 'Pakistan';
    });
  }

  @override
  void dispose() {
    nameController.clear();
    cityController.clear();
    streetController.clear();
    zipController.clear();
    nameController.dispose();
    cityController.dispose();
    streetController.dispose();
    zipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TopHeader(text: 'Edit Profile'),
        const SizedBox(height: 20),
        customField(
          text: 'arjun',
          controller: nameController,
          icon: 'assets/images/Profile.svg',
        ),
        const SizedBox(height: 20),
        customField(
          text: 'Street',
          controller: streetController,
          icon: 'assets/images/Home.svg',
        ),
        const SizedBox(height: 20),
        customField(
          text: 'City',
          controller: cityController,
          icon: 'assets/images/Location.svg',
        ),
        const SizedBox(height: 20),
        customField(
          text: 'Zip code',
          isNumerical: true,
          controller: zipController,
          icon: 'assets/images/Message.svg',
        ),
        const SizedBox(height: 20),
        Container(
          height: 60,
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
            showCountryOnly: true,
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
        SizedBox(height: Get.height * 0.1),
        CustomButton(
          height: 60,
          width: Get.width * 0.8,
          text: 'Update',
          color: customYellow,
          onPressed: () async {
            await widget.profileScreenController.updateProfile(
              userId: getStorage.read('userId'),
              name: nameController.text,
              city: cityController.text,
              street: streetController.text,
              zipCode: int.parse(zipController.text),
              country: country,
            );
            Get.back();
          },
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

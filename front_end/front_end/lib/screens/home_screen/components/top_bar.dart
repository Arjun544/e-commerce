import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front_end/utils/colors.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          'assets/images/Category.svg',
          height: 25,
          color: darkBlue,
        ),
        Row(
          children: [
            SvgPicture.asset(
              'assets/images/Search.svg',
              height: 25,
              color: Colors.grey.withOpacity(0.5),
            ),
            SizedBox(width: 20),
            Container(child: Image.asset('assets/arjun profile.jpg'),),
            SizedBox(width: 5),
          ],
        ),
      ],
    );
  }
}

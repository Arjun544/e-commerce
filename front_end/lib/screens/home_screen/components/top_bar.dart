import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/colors.dart';

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
            const SizedBox(width: 20),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                  image: AssetImage('assets/arjun profile.jpg'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

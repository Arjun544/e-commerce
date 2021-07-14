import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import 'package:get/get.dart';

class ArrivalsSection extends StatelessWidget {
  const ArrivalsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.22,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          padding: const EdgeInsets.only(left: 15),
          itemBuilder: (context, index) {
            return index == 3
                ? Container(
                    width: 80,
                    margin: const EdgeInsets.only(right: 10),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      'See All',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  )
                : Stack(
                    clipBehavior: Clip.hardEdge,
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: Get.width * 0.6,
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: darkBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: BuildItem(),
                      ),
                      Positioned(
                        right: 10,
                        child: Container(
                          width: 40,
                          height: 30,
                          decoration: const BoxDecoration(
                            color: customYellow,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              topLeft: Radius.circular(15),
                            ),
                          ),
                          child: const Icon(
                            Icons.add_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  );
          }),
    );
  }
}

class BuildItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: Get.height * 0.13,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            // image: DecorationImage(
            //   image: AssetImage('assets/arjun profile.jpg'),
            // ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Name',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const Text(
                    r'$60',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

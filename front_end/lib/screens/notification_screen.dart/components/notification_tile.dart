import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../utils/colors.dart';
import '../../../models/notification_model.dart' as model;
import 'package:get/get.dart';

class NotificationTile extends StatelessWidget {
  final model.Notification notification;
  final VoidCallback onTap;
  final VoidCallback onDeleteTap;

  const NotificationTile(
      {Key? key,
      required this.notification,
      required this.onTap,
      required this.onDeleteTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: Get.height * 0.13,
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: notification.hasRead ? customGrey : Colors.grey[300],
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title.toString(),
                    style: TextStyle(
                      fontSize: Get.height * 0.02,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    notification.body.toString(),
                    style: TextStyle(
                        fontSize: Get.height * 0.017,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('dd-MM-yyyy')
                      .format(notification.createdAt.toLocal()),
                  style: TextStyle(
                      fontSize: Get.height * 0.017,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey),
                ),
                IconButton(
                  onPressed: onDeleteTap,
                  icon: Icon(
                    Icons.delete_rounded,
                    color: Colors.red[300],
                    size: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

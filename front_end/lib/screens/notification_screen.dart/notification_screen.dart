import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../controllers/profile_screen_controller.dart';
import '../profile_screen/components/track_order.dart';
import '../../models/notification_model.dart' as notificationModel;
import 'components/notification_tile.dart';
import '../register_screen/register_screen.dart';
import '../../services/notification_api.dart';
import '../../utils/constants.dart';
import 'package:rxdart/rxdart.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final ProfileScreenController profileScreenController = Get.find();
  final StreamController<notificationModel.NotificationModel>
      notificationController = BehaviorSubject();
  RxInt currentTab = 1.obs;

  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      if (getStorage.read('isLogin') != true) {
        Get.to(() => RegisterScreen());
      } else {
        getNotifications();
      }
    });
    super.initState();
  }

  void getNotifications() async {
    await NotificationApi().getNotifications(
        notificationController: notificationController,
        userId: getStorage.read('userId'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.only(top: Get.height * 0.06),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'Notifications',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    StreamBuilder<notificationModel.NotificationModel>(
                        stream: notificationController.stream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const SizedBox();
                          } else if (snapshot.data == null) {}
                          notificationModel.NotificationModel?
                              notificationsData = snapshot.data;
                          return notificationsData!.notifications.isEmpty
                              ? const SizedBox.shrink()
                              : PopupMenuButton(
                                  offset: const Offset(50, 40),
                                  itemBuilder: (_) => <PopupMenuItem<String>>[
                                        PopupMenuItem<String>(
                                          value: 'Mark all as read',
                                          onTap: () async {
                                            List<String> ids = notificationsData
                                                .notifications
                                                .where(
                                                    (e) => e.hasRead == false)
                                                .map((e) => e.id)
                                                .toList();
                                            await NotificationApi()
                                                .markAllAsRead(
                                              ids: ids,
                                              userId: getStorage.read('userId'),
                                            );
                                            setState(() {
                                              getNotifications();
                                            });
                                          },
                                          child: const Text(
                                            'Mark all as read',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        PopupMenuItem<String>(
                                          value: 'Clear all',
                                          onTap: () async {
                                            await NotificationApi().clearAll(
                                              userId: getStorage.read('userId'),
                                            );
                                            setState(() {
                                              getNotifications();
                                            });
                                          },
                                          child: const Text(
                                            'Clear all',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                  onSelected: (_) {});
                        }),
                  ],
                ),
                StreamBuilder<notificationModel.NotificationModel>(
                    stream: notificationController.stream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox();
                      } else if (snapshot.data == null) {}
                      notificationModel.NotificationModel? notificationsData =
                          snapshot.data;

                      return notificationsData!.notifications.isEmpty
                          ? Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: const Text(
                                  'No Notifications',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      letterSpacing: 1),
                                ),
                              ),
                            )
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: notificationsData.notifications.length,
                              padding: const EdgeInsets.only(
                                  top: 15, right: 12, left: 12),
                              itemBuilder: (context, index) {
                                return Container(
                                  width: Get.width * 0.8,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: NotificationTile(
                                    notification: notificationsData
                                        .notifications.reversed
                                        .toList()[index],
                                    onTap: () async {
                                      // Update hasRead to true
                                      if (notificationsData
                                              .notifications[index].hasRead ==
                                          false) {
                                        await NotificationApi().updateHasRead(
                                            id: notificationsData
                                                .notifications[index].id);
                                      }

                                      profileScreenController
                                              .trackIdController.value =
                                          TextEditingController(
                                              text: notificationsData
                                                  .notifications[index].body
                                                  .split(' ')[4]);
                                      await Get.to(() => const TrackOrder());
                                      setState(() {
                                        getNotifications();
                                      });
                                    },
                                    onDeleteTap: () async {
                                      await NotificationApi()
                                          .deleteNotification(
                                              id: notificationsData
                                                  .notifications[index].id);
                                      setState(() {
                                        getNotifications();
                                      });
                                    },
                                  ),
                                );
                              });
                    }),
              ],
            ),
          ),
        ));
  }
}

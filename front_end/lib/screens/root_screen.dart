import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:badges/badges.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'profile_screen/components/track_order.dart';
import 'package:get/get.dart';

import '../controllers/cart_screen_controller.dart';
import '../controllers/home_screen_controller.dart';
import '../controllers/profile_screen_controller.dart';
import '../controllers/register_screen_controller.dart';
import '../controllers/root_screen_controller.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../widgets/customDialogue.dart';
import 'cart_screen/cart_screen.dart';
import 'home_screen/components/custom_bar.dart';
import 'home_screen/home_screen.dart';
import 'notification_screen.dart/notification_screen.dart';
import 'wishlist_screen.dart';

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final RootScreenController rootScreenController = Get.find();
  final CartScreenController cartScreenController = Get.find();
  final RegisterScreenController registerScreenController = Get.find();
  final ProfileScreenController profileScreenController = Get.find();
  final HomeScreenController homeScreenController = Get.find();

  final List<Widget> children = [
    HomeScreen(),
    const WishlistScreen(),
    const NotificationScreen(),
  ];

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        await AwesomeNotifications().createNotification(
          content: message.data['image'] == null
              ? NotificationContent(
                  id: 10,
                  channelKey: 'noti_key',
                  title: notification.title,
                  body: notification.body,
                )
              : NotificationContent(
                  id: 10,
                  channelKey: 'noti_key',
                  body: notification.body,
                  bigPicture: message.data['image'],
                  notificationLayout: NotificationLayout.BigPicture,
                ),
        );
      }
    });

    //  FirebaseMessaging.onBackgroundMessage.((RemoteMessage message) async {
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   if (notification != null && android != null) {
    //     await AwesomeNotifications().createNotification(
    //       content: message.data['image'] == null
    //           ? NotificationContent(
    //               id: 10,
    //               channelKey: 'noti_key',
    //               title: notification.title,
    //               body: notification.body,
    //             )
    //           : NotificationContent(
    //               id: 10,
    //               channelKey: 'noti_key',
    //               body: notification.body,
    //               bigPicture: message.data['image'],
    //               notificationLayout: NotificationLayout.BigPicture,
    //             ),
    //     );
    //   }
    // });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null && message.data['type'] == 'order') {
        profileScreenController.trackIdController.value =
            TextEditingController(text: message.data['orderId']);
        Get.to(
          () => const TrackOrder(),
        );
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (getStorage.read('isLogin') == true) {
        await rootScreenController.getCurrentUser();
        homeScreenController.cartLength.value = await homeScreenController
            .cartCount(userId: getStorage.read('userId'));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        body: children[rootScreenController.currentIndex.value],
        floatingActionButton: Obx(
          () => AnimatedContainer(
            duration: const Duration(milliseconds: 700),
            height: rootScreenController.isBottomBarVisible.value
                ? Get.height * 0.08
                : 0.0,
            child: FloatingActionButton(
              backgroundColor: darkBlue,
              onPressed: () async {
                getStorage.read('isLogin') == true
                    ? Get.to(
                        () => CartScreen(),
                      )
                    : AccessDialogue(context);
              },
              child: Badge(
                showBadge: rootScreenController.isBottomBarVisible.value
                    ? true
                    : false,
                badgeContent: getStorage.read('isLogin') == true
                    ? Obx(
                        () => Text(
                          homeScreenController.cartLength.value.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontSize: 12),
                        ),
                      )
                    : const Text(
                        '0',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: 12),
                      ),
                badgeColor: Colors.white,
                child: SvgPicture.asset(
                  'assets/images/Bag.svg',
                  height: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: CustomBar(
          controller: rootScreenController,
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import 'controllers_binding.dart';
import 'screens/splash_screen.dart';
import 'utils/colors.dart';
import 'utils/constants.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.data}');

  await AwesomeNotifications().createNotificationFromJsonData(message.data);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  sharedPreferences = await StreamingSharedPreferences.instance;
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
          channelGroupKey: 'notiGroup_key',
          channelKey: 'noti_key',
          channelName: 'notiChannel_name',
          channelDescription: 'notiChannel_desc',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
        ),
      ]);
  AwesomeNotifications()
      .actionStream
      .listen((ReceivedNotification receivedNotification) {
    log(receivedNotification.title.toString());
  });

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  String? token = await FirebaseMessaging.instance.getToken();
  await FirebaseMessaging.instance.subscribeToTopic('AllUsers');
  log(token!);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Nunito',
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        dividerColor: Colors.transparent,
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: customYellow,
          selectionColor: customYellow.withOpacity(0.3), // Change bubble to red
          cursorColor: Colors.black,
        ),
        textTheme: const TextTheme(
          headline6: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      initialBinding: ControllersBinding(),
      home: SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}

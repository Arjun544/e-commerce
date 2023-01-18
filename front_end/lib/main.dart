import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'services/notification_api.dart';
import 'screens/root_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import 'controllers_binding.dart';
import 'utils/colors.dart';
import 'utils/constants.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await AwesomeNotifications().createNotificationFromJsonData(message.data);
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
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
  await AwesomeNotifications().setListeners(
    onActionReceivedMethod: (receivedAction) async {},
  );

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  if (getStorage.read('isLogin') != true) {
    await FirebaseMessaging.instance.subscribeToTopic('AllUsers');
  } else if (getStorage.read('isLogin') == true) {
    FirebaseMessaging.instance.onTokenRefresh.listen((token) async {
      await NotificationApi()
          .addToken(token: token, id: getStorage.read('userId'));
    });
  }

  void configLoading() {
    EasyLoading.instance
      ..userInteractions = false
      ..dismissOnTap = false;
  }

  runApp(MyApp());
  configLoading();
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SellCorner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Nunito',
        primaryColor: Colors.white,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
        scaffoldBackgroundColor: Colors.white,
        dividerColor: Colors.transparent,
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: customYellow,
          selectionColor: customYellow.withOpacity(0.3),
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
      home: RootScreen(),
      builder: EasyLoading.init(),
    );
  }
}

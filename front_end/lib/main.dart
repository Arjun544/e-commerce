import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import 'controllers_binding.dart';
import 'screens/splash_screen.dart';
import 'utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  sharedPreferences = await StreamingSharedPreferences.instance;
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
      ),
      initialBinding: ControllersBinding(),
      home: SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}

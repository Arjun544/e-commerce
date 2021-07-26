import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

Dio dio = Dio();
const String baseUrl = 'https://sell-corner.herokuapp.com/api/';
final GetStorage getStorage = GetStorage();
late StreamingSharedPreferences sharedPreferences;

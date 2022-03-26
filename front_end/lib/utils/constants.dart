import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

Dio dio = Dio();
// const String baseUrl = 'https://sell-corner.herokuapp.com/api/';
// const String baseUrl = 'http://192.168.0.101:4000/api/';
const String baseUrl = 'http://192.168.1.151:4000/api/';
final GetStorage getStorage = GetStorage();
late StreamingSharedPreferences sharedPreferences;

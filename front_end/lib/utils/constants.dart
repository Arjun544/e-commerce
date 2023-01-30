import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

Dio dio = Dio();
// const String baseUrl = 'e-commerce-production-45e7.up.railway.app/api/';
// const String baseUrl = 'http://192.168.43.29:4000/api/';
const String baseUrl = 'http://192.168.43.29:4000/api/';
final GetStorage getStorage = GetStorage();
late StreamingSharedPreferences sharedPreferences;

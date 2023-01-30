import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

Dio dio = Dio();
const String baseUrl = 'https://e-commerce-production-45e7.up.railway.app/api/';
final GetStorage getStorage = GetStorage();
late StreamingSharedPreferences sharedPreferences;

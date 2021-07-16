// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
     this.success,
     this.data,
  });

  bool? success;
  Data? data;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        success: json['success'],
        data: Data.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data?.toJson(),
      };
}

class Data {
  Data({
    required this.isAdmin,
    required this.street,
    required this.apartment,
    required this.zip,
    required this.city,
    required this.country,
    required this.active,
    required this.id,
    required this.username,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.dataId,
  });

  bool isAdmin;
  String street;
  String apartment;
  String zip;
  String city;
  String country;
  bool active;
  String id;
  String username;
  String email;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String dataId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        isAdmin: json['isAdmin'],
        street: json['street'],
        apartment: json['apartment'],
        zip: json['zip'],
        city: json['city'],
        country: json['country'],
        active: json['active'],
        id: json['_id'],
        username: json['username'],
        email: json['email'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        v: json['__v'],
        dataId: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'isAdmin': isAdmin,
        'street': street,
        'apartment': apartment,
        'zip': zip,
        'city': city,
        'country': country,
        'active': active,
        '_id': id,
        'username': username,
        'email': email,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        '__v': v,
        'id': dataId,
      };
}

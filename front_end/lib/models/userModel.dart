// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.success,
    required this.data,
  });

  final bool success;
  final Data data;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        success: json['success'],
        data: Data.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data.toJson(),
      };
}

class Data {
  Data({
    required this.profile,
    required this.street,
    required this.shippingAddress,
    required this.zip,
    required this.city,
    required this.country,
    required this.customerId,
    required this.active,
    required this.deviceTokens,
    required this.id,
    required this.username,
    required this.email,
    required this.dataId,
  });

  final String profile;
  final String street;
  final List<ShippingAddress> shippingAddress;
  final String zip;
  final String city;
  final String country;
  final String customerId;
  final bool active;
  final List<String> deviceTokens;
  final String id;
  final String username;
  final String email;
  final String dataId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        profile: json['profile'],
        street: json['street'],
        shippingAddress: List<ShippingAddress>.from(
            json['ShippingAddress'].map((x) => ShippingAddress.fromJson(x))),
        zip: json['zip'],
        city: json['city'],
        country: json['country'],
        customerId: json['customerId'],
        active: json['active'],
        deviceTokens: List<String>.from(json['deviceTokens'].map((x) => x)),
        id: json['_id'],
        username: json['username'],
        email: json['email'],
        dataId: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'profile': profile,
        'street': street,
        'ShippingAddress':
            List<dynamic>.from(shippingAddress.map((x) => x.toJson())),
        'zip': zip,
        'city': city,
        'country': country,
        'customerId': customerId,
        'active': active,
        'deviceTokens': List<dynamic>.from(deviceTokens.map((x) => x)),
        '_id': id,
        'username': username,
        'email': email,
        'id': dataId,
      };
}

class ShippingAddress {
  ShippingAddress({
    required this.id,
    required this.address,
    required this.city,
    required this.country,
    required this.phone,
    required this.type,
  });

  final String id;
  final String address;
  final String city;
  final String country;
  final String phone;
  final String type;

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        id: json['id'],
        address: json['address'],
        city: json['city'],
        country: json['country'],
        phone: json['phone'],
        type: json['type'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'address': address,
        'city': city,
        'country': country,
        'phone': phone,
        'type': type,
      };
}

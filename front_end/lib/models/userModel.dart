// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.success,
    required this.data,
  });

  bool success;
  Data data;

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
    required this.active,
    required this.id,
    required this.username,
    required this.email,
    required this.dataId,
  });

  String profile;
  String street;
  List<ShipAddress> shippingAddress;
  String zip;
  String city;
  String country;
  bool active;
  String id;
  String username;
  String email;
  String dataId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        profile: json['profile'],
        street: json['street'],
        shippingAddress: List<ShipAddress>.from(
            json['ShippingAddress'].map((x) => ShipAddress.fromJson(x))),
        zip: json['zip'],
        city: json['city'],
        country: json['country'],
        active: json['active'],
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
        'active': active,
        '_id': id,
        'username': username,
        'email': email,
        'id': dataId,
      };
}

class ShipAddress {
  ShipAddress({
    required this.id,
    required this.address,
    required this.city,
    required this.country,
    required this.phone,
    required this.type,
  });

  String id;
  String address;
  String city;
  String country;
  String phone;
  String type;

  factory ShipAddress.fromJson(Map<String, dynamic> json) => ShipAddress(
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

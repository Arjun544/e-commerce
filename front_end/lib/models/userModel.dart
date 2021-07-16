import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.user,
  });

  User user;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        user: User.fromJson(json['user']),
      );

  Map<String, dynamic> toJson() => {
        'user': user.toJson(),
      };
}

class User {
  User({
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
    required this.userId,
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
  String userId;

  factory User.fromJson(Map<String, dynamic> json) => User(
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
        userId: json['id'],
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
        'id': userId,
      };
}

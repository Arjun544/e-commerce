import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.success,
    required this.token,
    required this.user,
    required this.message,
  });

  bool success;
  String token;
  User user;
  String message;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        success: json['success'],
        token: json['token'],
        user: User.fromJson(json['user']),
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'token': token,
        'user': user.toJson(),
        'message': message,
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
    required this.resetPasswordToken,
    required this.resetPasswordExpires,
    required this.emailToken,
    required this.emailTokenExpires,
    required this.id,
    required this.username,
    required this.email,
    required this.password,
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
  dynamic resetPasswordToken;
  dynamic resetPasswordExpires;
  String emailToken;
  dynamic emailTokenExpires;
  String id;
  String username;
  String email;
  String password;
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
        resetPasswordToken: json['resetPasswordToken'],
        resetPasswordExpires: json['resetPasswordExpires'],
        emailToken: json['emailToken'],
        emailTokenExpires: json['emailTokenExpires'],
        id: json['_id'],
        username: json['username'],
        email: json['email'],
        password: json['password'],
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
        'resetPasswordToken': resetPasswordToken,
        'resetPasswordExpires': resetPasswordExpires,
        'emailToken': emailToken,
        'emailTokenExpires': emailTokenExpires,
        '_id': id,
        'username': username,
        'email': email,
        'password': password,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'id': userId,
      };
}

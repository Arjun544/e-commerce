// // To parse this JSON data, do
// //
// //     final orderModel = orderModelFromJson(jsonString);

// import 'package:meta/meta.dart';
// import 'dart:convert';

// OrderModel orderModelFromJson(String str) =>
//     OrderModel.fromJson(json.decode(str));

// String orderModelToJson(OrderModel data) => json.encode(data.toJson());

// class OrderModel {
//   OrderModel({
//     required this.sucess,
//     required this.orderList,
//   });

//   bool sucess;
//   List<OrderList> orderList;

//   factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
//         sucess: json['sucess'],
//         orderList: List<OrderList>.from(
//             json['orderList'].map((x) => OrderList.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         'sucess': sucess,
//         'orderList': List<dynamic>.from(orderList.map((x) => x.toJson())),
//       };
// }

// class OrderList {
//   OrderList({
//     required this.orderItems,
//     required this.status,
//     required this.id,
//     required this.shippingAddress1,
//     required this.shippingAddress2,
//     required this.payment,
//     required this.city,
//     required this.zip,
//     required this.country,
//     required this.phone,
//     required this.totalPrice,
//     required this.user,
//     required this.dateOrdered,
//     required this.v,
//     required this.orderListId,
//     required this.deliveryType,
//   });

//   List<String> orderItems;
//   String status;
//   String id;
//   String shippingAddress1;
//   String shippingAddress2;
//   String payment;
//   String city;
//   String zip;
//   String country;
//   String phone;
//   int totalPrice;
//   User user;
//   DateTime dateOrdered;
//   int v;
//   String orderListId;
//   String deliveryType;

//   factory OrderList.fromJson(Map<String, dynamic> json) => OrderList(
//         orderItems: List<String>.from(json['orderItems'].map((x) => x)),
//         status: json['status'],
//         id: json['_id'],
//         shippingAddress1: json['shippingAddress1'],
//         shippingAddress2: json['shippingAddress2'],
//         payment: json['payment'] == null ? null : json['payment'],
//         city: json['city'],
//         zip: json['zip'],
//         country: json['country'],
//         phone: json['phone'],
//         totalPrice: json['totalPrice'],
//         user: json['user'] == null ? null : User.fromJson(json['user']),
//         dateOrdered: DateTime.parse(json['dateOrdered']),
//         v: json['__v'],
//         orderListId: json['id'],
//         deliveryType:
//             json['deliveryType'] == null ? null : json['deliveryType'],
//       );

//   Map<String, dynamic> toJson() => {
//         'orderItems': List<dynamic>.from(orderItems.map((x) => x)),
//         'status': status,
//         '_id': id,
//         'shippingAddress1': shippingAddress1,
//         'shippingAddress2': shippingAddress2,
//         'payment': payment == null ? null : payment,
//         'city': city,
//         'zip': zip,
//         'country': country,
//         'phone': phone,
//         'totalPrice': totalPrice,
//         'user': user == null ? null : user.toJson(),
//         'dateOrdered': dateOrdered.toIso8601String(),
//         '__v': v,
//         'id': orderListId,
//         'deliveryType': deliveryType == null ? null : deliveryType,
//       };
// }

// class User {
//   User({
//     required this.id,
//     required this.userId,
//   });

//   String id;
//   String userId;

//   factory User.fromJson(Map<String, dynamic> json) => User(
//         id: json['_id'],
//         userId: json['id'],
//       );

//   Map<String, dynamic> toJson() => {
//         '_id': id,
//         'id': userId,
//       };
// }

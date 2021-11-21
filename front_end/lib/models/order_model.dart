// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  OrderModel({
    required this.success,
    required this.orderList,
  });

  bool success;
  List<OrderList> orderList;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        success: json['success'],
        orderList: List<OrderList>.from(
            json['orderList'].map((x) => OrderList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'orderList': List<dynamic>.from(orderList.map((x) => x.toJson())),
      };
}

class OrderList {
  OrderList({
    required this.orderItems,
    required this.status,
    required this.isPaid,
    required this.id,
    required this.shippingAddress,
    required this.payment,
    required this.deliveryType,
    required this.deliveryFee,
    required this.city,
    required this.country,
    required this.phone,
    required this.totalPrice,
    required this.user,
    required this.dateOrdered,
    required this.v,
    required this.orderListId,
  });

  List<OrderItem> orderItems;
  String status;
  bool isPaid;
  String id;
  String shippingAddress;
  String payment;
  String deliveryType;
  int deliveryFee;
  String city;
  String country;
  String phone;
  int totalPrice;
  User user;
  DateTime dateOrdered;
  int v;
  String orderListId;

  factory OrderList.fromJson(Map<String, dynamic> json) => OrderList(
        orderItems: List<OrderItem>.from(
            json['orderItems'].map((x) => OrderItem.fromJson(x))),
        status: json['status'],
        isPaid: json['isPaid'],
        id: json['_id'],
        shippingAddress: json['shippingAddress'],
        payment: json['payment'],
        deliveryType: json['deliveryType'],
        deliveryFee: json['deliveryFee'],
        city: json['city'],
        country: json['country'],
        phone: json['phone'],
        totalPrice: json['totalPrice'],
        user: User.fromJson(json['user']),
        dateOrdered: DateTime.parse(json['dateOrdered']),
        v: json['__v'],
        orderListId: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'orderItems': List<dynamic>.from(orderItems.map((x) => x.toJson())),
        'status': status,
        'isPaid': isPaid,
        '_id': id,
        'shippingAddress': shippingAddress,
        'payment': payment,
        'deliveryType': deliveryType,
        'deliveryFee': deliveryFee,
        'city': city,
        'country': country,
        'phone': phone,
        'totalPrice': totalPrice,
        'user': user.toJson(),
        'dateOrdered': dateOrdered.toIso8601String(),
        '__v': v,
        'id': orderListId,
      };
}

class OrderItem {
  OrderItem({
    required this.quantity,
    required this.fullDescription,
    required this.images,
    required this.price,
    required this.onSale,
    required this.totalPrice,
    required this.discount,
    required this.totalReviews,
    required this.reviews,
    required this.isFeatured,
    required this.isReviewed,
    required this.status,
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnail,
    required this.thumbnailId,
    required this.category,
    required this.subCategory,
    required this.countInStock,
    required this.dateCreated,
    required this.v,
    required this.orderItemId,
  });

  int quantity;
  String fullDescription;
  List<Image> images;
  int price;
  bool onSale;
  int totalPrice;
  int discount;
  int totalReviews;
  List<dynamic> reviews;
  bool isFeatured;
  bool isReviewed;
  bool status;
  String id;
  String name;
  String description;
  String thumbnail;
  String thumbnailId;
  Category category;
  String subCategory;
  int countInStock;
  DateTime dateCreated;
  int v;
  String orderItemId;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        quantity: json['quantity'],
        fullDescription: json['fullDescription'],
        images: List<Image>.from(json['images'].map((x) => Image.fromJson(x))),
        price: json['price'],
        onSale: json['onSale'],
        totalPrice: json['totalPrice'],
        discount: json['discount'],
        totalReviews: json['totalReviews'],
        reviews: List<dynamic>.from(json['reviews'].map((x) => x)),
        isFeatured: json['isFeatured'],
        isReviewed: json['isReviewed'],
        status: json['status'],
        id: json['_id'],
        name: json['name'],
        description: json['description'],
        thumbnail: json['thumbnail'],
        thumbnailId: json['thumbnailId'],
        category: Category.fromJson(json['category']),
        subCategory: json['subCategory'],
        countInStock: json['countInStock'],
        dateCreated: DateTime.parse(json['dateCreated']),
        v: json['__v'],
        orderItemId: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'quantity': quantity,
        'fullDescription': fullDescription,
        'images': List<dynamic>.from(images.map((x) => x.toJson())),
        'price': price,
        'onSale': onSale,
        'totalPrice': totalPrice,
        'discount': discount,
        'totalReviews': totalReviews,
        'reviews': List<dynamic>.from(reviews.map((x) => x)),
        'isFeatured': isFeatured,
        'status': status,
        '_id': id,
        'name': name,
        'description': description,
        'thumbnail': thumbnail,
        'thumbnailId': thumbnailId,
        'category': category.toJson(),
        'subCategory': subCategory,
        'countInStock': countInStock,
        'dateCreated': dateCreated.toIso8601String(),
        '__v': v,
        'id': orderItemId,
      };
}

class Category {
  Category({
    required this.subCategories,
    required this.status,
    required this.id,
    required this.name,
    required this.icon,
    required this.iconId,
    required this.v,
    required this.categoryId,
  });

  List<SubCategory> subCategories;
  bool status;
  String id;
  String name;
  String icon;
  String iconId;
  int v;
  String categoryId;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        subCategories: List<SubCategory>.from(
            json['subCategories'].map((x) => SubCategory.fromJson(x))),
        status: json['status'],
        id: json['_id'],
        name: json['name'],
        icon: json['icon'],
        iconId: json['iconId'],
        v: json['__v'],
        categoryId: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'subCategories':
            List<dynamic>.from(subCategories.map((x) => x.toJson())),
        'status': status,
        '_id': id,
        'name': name,
        'icon': icon,
        'iconId': iconId,
        '__v': v,
        'id': categoryId,
      };
}

class SubCategory {
  SubCategory({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}

class Image {
  Image({
    required this.id,
    required this.url,
  });

  String id;
  String url;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json['id'],
        url: json['url'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'url': url,
      };
}

class User {
  User({
    required this.profile,
    required this.street,
    required this.shippingAddress,
    required this.zip,
    required this.city,
    required this.country,
    required this.active,
    required this.id,
    required this.username,
    required this.customerId,
    required this.email,
    required this.userId,
  });

  String profile;
  String street;
  List<ShippingAddress> shippingAddress;
  String zip;
  String city;
  String country;
  bool active;
  String id;
  String username;
  String customerId;
  String email;
  String userId;

  factory User.fromJson(Map<String, dynamic> json) => User(
        profile: json['profile'],
        street: json['street'],
        shippingAddress: List<ShippingAddress>.from(
            json['ShippingAddress'].map((x) => ShippingAddress.fromJson(x))),
        zip: json['zip'],
        city: json['city'],
        country: json['country'],
        active: json['active'],
        id: json['_id'],
        username: json['username'],
        customerId: json['customerId'],
        email: json['email'],
        userId: json['id'],
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
        'customerId': customerId,
        'email': email,
        'id': userId,
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

  String id;
  String address;
  String city;
  String country;
  String phone;
  String type;

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

// To parse this JSON data, do
//
//     final trackOrderModel = trackOrderModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

TrackOrderModel trackOrderModelFromJson(String str) =>
    TrackOrderModel.fromJson(json.decode(str));

String trackOrderModelToJson(TrackOrderModel data) =>
    json.encode(data.toJson());

class TrackOrderModel {
  TrackOrderModel({
    required this.success,
    required this.orderList,
  });

  bool success;
  OrderList orderList;

  factory TrackOrderModel.fromJson(Map<String, dynamic> json) =>
      TrackOrderModel(
        success: json['success'],
        orderList: OrderList.fromJson(json['orderList']),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'orderList': orderList.toJson(),
      };
}

class OrderList {
  OrderList({
    required this.orderItems,
    required this.status,
    required this.id,
    required this.shippingAddress,
    required this.payment,
    required this.deliveryType,
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
  String id;
  String shippingAddress;
  String payment;
  String deliveryType;
  String city;
  String country;
  String phone;
  int totalPrice;
  dynamic user;
  DateTime dateOrdered;
  int v;
  String orderListId;

  factory OrderList.fromJson(Map<String, dynamic> json) => OrderList(
        orderItems: List<OrderItem>.from(
            json['orderItems'].map((x) => OrderItem.fromJson(x))),
        status: json['status'],
        id: json['_id'],
        shippingAddress: json['shippingAddress'],
        payment: json['payment'],
        deliveryType: json['deliveryType'],
        city: json['city'],
        country: json['country'],
        phone: json['phone'],
        totalPrice: json['totalPrice'],
        user: json['user'],
        dateOrdered: DateTime.parse(json['dateOrdered']),
        v: json['__v'],
        orderListId: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'orderItems': List<dynamic>.from(orderItems.map((x) => x.toJson())),
        'status': status,
        '_id': id,
        'shippingAddress': shippingAddress,
        'payment': payment,
        'deliveryType': deliveryType,
        'city': city,
        'country': country,
        'phone': phone,
        'totalPrice': totalPrice,
        'user': user,
        'dateOrdered': dateOrdered.toIso8601String(),
        '__v': v,
        'id': orderListId,
      };
}

class OrderItem {
  OrderItem({
    required this.id,
    required this.quantity,
    required this.product,
    required this.v,
  });

  String id;
  int quantity;
  Product product;
  int v;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json['_id'],
        quantity: json['quantity'],
        product: Product.fromJson(json['product']),
        v: json['__v'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'quantity': quantity,
        'product': product.toJson(),
        '__v': v,
      };
}

class Product {
  Product({
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
    required this.productId,
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
  String productId;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
        productId: json['id'],
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
        'id': productId,
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

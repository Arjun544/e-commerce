// To parse this JSON data, do
//
//     final dealModel = dealModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'product_Model.dart';

DealModel dealModelFromJson(String str) => DealModel.fromJson(json.decode(str));

String dealModelToJson(DealModel data) => json.encode(data.toJson());

class DealModel {
  DealModel({
    required this.success,
    required this.deals,
  });

  bool success;
  List<Deal> deals;

  factory DealModel.fromJson(Map<String, dynamic> json) => DealModel(
        success: json['success'],
        deals: List<Deal>.from(json['deals'].map((x) => Deal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'deals': List<dynamic>.from(deals.map((x) => x.toJson())),
      };
}

class Deal {
  Deal({
    required this.status,
    required this.products,
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.v,
    required this.dealId,
  });

  bool status;
  List<Product> products;
  String id;
  String title;
  DateTime startDate;
  DateTime endDate;
  int v;
  String dealId;

  factory Deal.fromJson(Map<String, dynamic> json) => Deal(
        status: json['status'],
        products: List<Product>.from(
            json['products'].map((x) => Product.fromJson(x))),
        id: json['_id'],
        title: json['title'],
        startDate: DateTime.parse(json['startDate']),
        endDate: DateTime.parse(json['endDate']),
        v: json['__v'],
        dealId: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'products': List<dynamic>.from(products.map((x) => x.toJson())),
        '_id': id,
        'title': title,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        '__v': v,
        'id': dealId,
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

class Review {
  Review({
    required this.id,
    required this.user,
    required this.review,
    required this.rating,
    required this.product,
    required this.addedAt,
    required this.v,
  });

  String id;
  User user;
  String review;
  int rating;
  ReviewProduct product;
  DateTime addedAt;
  int v;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json['_id'],
        user: User.fromJson(json['user']),
        review: json['review'],
        rating: json['rating'],
        product: ReviewProduct.fromJson(json['product']),
        addedAt: DateTime.parse(json['addedAt']),
        v: json['__v'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'user': user.toJson(),
        'review': review,
        'rating': rating,
        'product': product.toJson(),
        'addedAt': addedAt.toIso8601String(),
        '__v': v,
      };
}

class ReviewProduct {
  ReviewProduct({
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
  String category;
  String subCategory;
  int countInStock;
  DateTime dateCreated;
  int v;

  factory ReviewProduct.fromJson(Map<String, dynamic> json) => ReviewProduct(
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
        category: json['category'],
        subCategory: json['subCategory'],
        countInStock: json['countInStock'],
        dateCreated: DateTime.parse(json['dateCreated']),
        v: json['__v'],
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
        'category': category,
        'subCategory': subCategory,
        'countInStock': countInStock,
        'dateCreated': dateCreated.toIso8601String(),
        '__v': v,
      };
}

class User {
  User({
    required this.profile,
    required this.isAdmin,
    required this.street,
    required this.shippingAddress,
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
  });

  String profile;
  bool isAdmin;
  String street;
  List<dynamic> shippingAddress;
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

  factory User.fromJson(Map<String, dynamic> json) => User(
        profile: json['profile'],
        isAdmin: json['isAdmin'],
        street: json['street'],
        shippingAddress:
            List<dynamic>.from(json['ShippingAddress'].map((x) => x)),
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
      );

  Map<String, dynamic> toJson() => {
        'profile': profile,
        'isAdmin': isAdmin,
        'street': street,
        'ShippingAddress': List<dynamic>.from(shippingAddress.map((x) => x)),
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
      };
}
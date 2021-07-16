// To parse this JSON data, do
//
//     final featuredProductModel = featuredProductModelFromJson(jsonString);

import 'package:front_end/models/userModel.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

FeaturedProductModel featuredProductModelFromJson(String str) =>
    FeaturedProductModel.fromJson(json.decode(str));

String featuredProductModelToJson(FeaturedProductModel data) =>
    json.encode(data.toJson());

class FeaturedProductModel {
  FeaturedProductModel({
    required this.featuredProducts,
  });

  List<FeaturedProduct> featuredProducts;

  factory FeaturedProductModel.fromJson(Map<String, dynamic> json) =>
      FeaturedProductModel(
        featuredProducts: List<FeaturedProduct>.from(
            json['featuredProducts'].map((x) => FeaturedProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'featuredProducts':
            List<dynamic>.from(featuredProducts.map((x) => x.toJson())),
      };
}

class FeaturedProduct {
  FeaturedProduct({
    required this.fullDescription,
    required this.image,
    required this.images,
    required this.price,
    required this.onSale,
    required this.totalPrice,
    required this.discount,
    required this.totalReviews,
    required this.reviews,
    required this.isFeatured,
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.countInStock,
    required this.dateCreated,
    required this.v,
    required this.saleDiscount,
    required this.featuredProductId,
  });

  String fullDescription;
  String image;
  List<String> images;
  int price;
  bool onSale;
  int totalPrice;
  int discount;
  int totalReviews;
  List<Review> reviews;
  bool isFeatured;
  String id;
  String name;
  String description;
  String category;
  int countInStock;
  DateTime dateCreated;
  int v;
  int saleDiscount;
  String featuredProductId;

  factory FeaturedProduct.fromJson(Map<String, dynamic> json) =>
      FeaturedProduct(
        fullDescription: json['fullDescription'],
        image: json['image'],
        images: List<String>.from(json['images'].map((x) => x)),
        price: json['price'],
        onSale: json['onSale'],
        totalPrice: json['totalPrice'],
        discount: json['discount'],
        totalReviews: json['totalReviews'],
        reviews:
            List<Review>.from(json['reviews'].map((x) => Review.fromJson(x))),
        isFeatured: json['isFeatured'],
        id: json['_id'],
        name: json['name'],
        description: json['description'],
        category: json['category'],
        countInStock: json['countInStock'],
        dateCreated: DateTime.parse(json['dateCreated']),
        v: json['__v'],
        saleDiscount:
            json['saleDiscount'] == null ? null : json['saleDiscount'],
        featuredProductId: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'fullDescription': fullDescription,
        'image': image,
        'images': List<dynamic>.from(images.map((x) => x)),
        'price': price,
        'onSale': onSale,
        'totalPrice': totalPrice,
        'discount': discount,
        'totalReviews': totalReviews,
        'reviews': List<dynamic>.from(reviews.map((x) => x.toJson())),
        'isFeatured': isFeatured,
        '_id': id,
        'name': name,
        'description': description,
        'category': category,
        'countInStock': countInStock,
        'dateCreated': dateCreated.toIso8601String(),
        '__v': v,
        'saleDiscount': saleDiscount == null ? null : saleDiscount,
        'id': featuredProductId,
      };
}

class Review {
  Review({
    required this.user,
    required this.review,
    required this.addedAt,
  });

  User? user;
  String review;
  int addedAt;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        user: json['user'] == null ? null : User.fromJson(json['user']),
        review: json['review'],
        addedAt: json['addedAt'],
      );

  Map<String, dynamic> toJson() => {
        'user': user == null ? null : User().toJson(),
        'review': review,
        'addedAt': addedAt,
      };
}

class User {
  User({
     this.id,
     this.username,
  });

  String? id;
  String? username;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['_id'],
        username: json['username'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'username': username,
      };
}

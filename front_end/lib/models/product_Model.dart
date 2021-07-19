// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  ProductModel({
    required this.fullDescription,
    required this.images,
    required this.price,
    required this.onSale,
    required this.favourites,
    required this.totalPrice,
    required this.discount,
    required this.totalReviews,
    required this.reviews,
    required this.isFeatured,
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.category,
    required this.countInStock,
    required this.dateCreated,
    required this.v,
    required this.productModelId,
  });

  String fullDescription;
  List<Image> images;
  int price;
  bool onSale;
  List<dynamic> favourites;
  int totalPrice;
  int discount;
  int totalReviews;
  List<dynamic> reviews;
  bool isFeatured;
  String id;
  String name;
  String description;
  String image;
  String category;
  int countInStock;
  DateTime dateCreated;
  int v;
  String productModelId;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        fullDescription: json['fullDescription'],
        images: List<Image>.from(json['images'].map((x) => Image.fromJson(x))),
        price: json['price'],
        onSale: json['onSale'],
        favourites: List<dynamic>.from(json['favourites'].map((x) => x)),
        totalPrice: json['totalPrice'],
        discount: json['discount'],
        totalReviews: json['totalReviews'],
        reviews: List<dynamic>.from(json['reviews'].map((x) => x)),
        isFeatured: json['isFeatured'],
        id: json['_id'],
        name: json['name'],
        description: json['description'],
        image: json['image'],
        category: json['category'],
        countInStock: json['countInStock'],
        dateCreated: DateTime.parse(json['dateCreated']),
        v: json['__v'],
        productModelId: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'fullDescription': fullDescription,
        'images': List<dynamic>.from(images.map((x) => x.toJson())),
        'price': price,
        'onSale': onSale,
        'favourites': List<dynamic>.from(favourites.map((x) => x)),
        'totalPrice': totalPrice,
        'discount': discount,
        'totalReviews': totalReviews,
        'reviews': List<dynamic>.from(reviews.map((x) => x)),
        'isFeatured': isFeatured,
        '_id': id,
        'name': name,
        'description': description,
        'image': image,
        'category': category,
        'countInStock': countInStock,
        'dateCreated': dateCreated.toIso8601String(),
        '__v': v,
        'id': productModelId,
      };
}

class Image {
  Image({
    required this.url,
  });

  String url;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        url: json['url'],
      );

  Map<String, dynamic> toJson() => {
        'url': url,
      };
}

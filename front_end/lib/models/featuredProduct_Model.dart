// To parse this JSON data, do
//
//     final featuredProductModel = featuredProductModelFromJson(jsonString);
import 'dart:convert';

List<FeaturedProductModel> featuredProductModelFromJson(String str) =>
    List<FeaturedProductModel>.from(
        json.decode(str).map((x) => FeaturedProductModel.fromJson(x)));

String featuredProductModelToJson(List<FeaturedProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FeaturedProductModel {
  FeaturedProductModel({
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
    required this.featuredProductModelId,
  });

  String fullDescription;
  String image;
  List<dynamic> images;
  int price;
  bool onSale;
  int totalPrice;
  int discount;
  int totalReviews;
  List<dynamic> reviews;
  bool isFeatured;
  String id;
  String name;
  String description;
  String category;
  int countInStock;
  DateTime dateCreated;
  int v;
  String featuredProductModelId;

  factory FeaturedProductModel.fromJson(Map<String, dynamic> json) =>
      FeaturedProductModel(
        fullDescription: json['fullDescription'],
        image: json['image'],
        images: List<dynamic>.from(json['images'].map((x) => x)),
        price: json['price'],
        onSale: json['onSale'],
        totalPrice: json['totalPrice'],
        discount: json['discount'],
        totalReviews: json['totalReviews'],
        reviews: List<dynamic>.from(json['reviews'].map((x) => x)),
        isFeatured: json['isFeatured'],
        id: json['_id'],
        name: json['name'],
        description: json['description'],
        category: json['category'],
        countInStock: json['countInStock'],
        dateCreated: DateTime.parse(json['dateCreated']),
        v: json['__v'],
        featuredProductModelId: json['id'],
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
        'reviews': List<dynamic>.from(reviews.map((x) => x)),
        'isFeatured': isFeatured,
        '_id': id,
        'name': name,
        'description': description,
        'category': category,
        'countInStock': countInStock,
        'dateCreated': dateCreated.toIso8601String(),
        '__v': v,
        'id': featuredProductModelId,
      };
}

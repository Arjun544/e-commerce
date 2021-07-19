// To parse this JSON data, do
//
//     final featuredProductModel = featuredProductModelFromJson(jsonString);
import 'dart:convert';

List<ProductModel> featuredProductModelFromJson(String str) =>
    List<ProductModel>.from(
        json.decode(str).map((x) => ProductModel.fromJson(x)));

String featuredProductModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  ProductModel({
    required this.fullDescription,
    required this.image,
    required this.images,
    required this.price,
     this.quantity = 1,
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
  List<String> images;
  int price;
  int? quantity;
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
  String featuredProductModelId;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      ProductModel(
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
        'reviews': List<dynamic>.from(reviews.map((x) => x.toJson())),
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

class Review {
  Review({
    required this.user,
    required this.review,
    required this.addedAt,
  });

  User user;
  String review;
  int addedAt;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        user: User.fromJson(json['user']),
        review: json['review'],
        addedAt: json['addedAt'],
      );

  Map<String, dynamic> toJson() => {
        'user': user.toJson(),
        'review': review,
        'addedAt': addedAt,
      };
}

class User {
  User({
    required this.id,
    required this.username,
  });

  String id;
  String username;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['_id'],
        username: json['username'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'username': username,
      };
}

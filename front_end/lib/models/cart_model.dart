// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  CartModel({
    required this.totalGrand,
    required this.cartList,
  });

  int totalGrand;
  List<CartList> cartList;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        totalGrand: json['totalGrand'],
        cartList: List<CartList>.from(
            json['cartList'].map((x) => CartList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'totalGrand': totalGrand,
        'cartList': List<dynamic>.from(cartList.map((x) => x.toJson())),
      };
}

class CartList {
  CartList({
    required this.cartItems,
    required this.id,
    required this.user,
    required this.dateOrdered,
    required this.v,
    required this.cartListId,
  });

  List<CartItem> cartItems;
  String id;
  String user;
  DateTime dateOrdered;
  int v;
  String cartListId;

  factory CartList.fromJson(Map<String, dynamic> json) => CartList(
        cartItems: List<CartItem>.from(
            json['cartItems'].map((x) => CartItem.fromJson(x))),
        id: json['_id'],
        user: json['user'],
        dateOrdered: DateTime.parse(json['dateOrdered']),
        v: json['__v'],
        cartListId: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'cartItems': List<dynamic>.from(cartItems.map((x) => x.toJson())),
        '_id': id,
        'user': user,
        'dateOrdered': dateOrdered.toIso8601String(),
        '__v': v,
        'id': cartListId,
      };
}

class CartItem {
  CartItem({
    required this.quantity,
    required this.id,
    required this.product,
    required this.userId,
    required this.v,
  });

  int quantity;
  String id;
  Product product;
  String userId;
  int v;

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        quantity: json['quantity'],
        id: json['_id'],
        product: Product.fromJson(json['product']),
        userId: json['userId'],
        v: json['__v'],
      );

  Map<String, dynamic> toJson() => {
        'quantity': quantity,
        '_id': id,
        'product': product.toJson(),
        'userId': userId,
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
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.category,
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
  List<Review> reviews;
  bool isFeatured;
  String id;
  String name;
  String description;
  String image;
  String category;
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
        reviews:
            List<Review>.from(json['reviews'].map((x) => Review.fromJson(x))),
        isFeatured: json['isFeatured'],
        id: json['_id'],
        name: json['name'],
        description: json['description'],
        image: json['image'],
        category: json['category'],
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
        'reviews': List<dynamic>.from(reviews.map((x) => x.toJson())),
        'isFeatured': isFeatured,
        '_id': id,
        'name': name,
        'description': description,
        'image': image,
        'category': category,
        'countInStock': countInStock,
        'dateCreated': dateCreated.toIso8601String(),
        '__v': v,
        'id': productId,
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

class Review {
  Review({
    required this.user,
    required this.review,
    required this.number,
    required this.addedAt,
  });

  User user;
  String review;
  String number;
  AddedAt addedAt;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        user: User.fromJson(json['user']),
        review: json['review'],
        number: json['number'],
        addedAt: AddedAt.fromJson(json['addedAt']),
      );

  Map<String, dynamic> toJson() => {
        'user': user.toJson(),
        'review': review,
        'number': number,
        'addedAt': addedAt.toJson(),
      };
}

class AddedAt {
  AddedAt({
    required this.id,
    required this.addedAt,
  });

  String id;
  DateTime addedAt;

  factory AddedAt.fromJson(Map<String, dynamic> json) => AddedAt(
        id: json['_id'],
        addedAt: DateTime.parse(json['addedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'addedAt': addedAt.toIso8601String(),
      };
}

class User {
  User({
    required this.profile,
    required this.id,
    required this.username,
  });

  String profile;
  String id;
  String username;

  factory User.fromJson(Map<String, dynamic> json) => User(
        profile: json['profile'],
        id: json['_id'],
        username: json['username'],
      );

  Map<String, dynamic> toJson() => {
        'profile': profile,
        '_id': id,
        'username': username,
      };
}

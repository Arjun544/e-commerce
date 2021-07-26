// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  CartModel({
     this.totalGrand,
     this.cartList,
  });

  int? totalGrand;
  List<CartList>? cartList;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        totalGrand: json['totalGrand'],
        cartList: List<CartList>.from(
            json['cartList'].map((x) => CartList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'totalGrand': totalGrand,
        'cartList': List<dynamic>.from(cartList!.map((x) => x.toJson())),
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
    required this.productId,
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
  String productId;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
        productId: json['id'],
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

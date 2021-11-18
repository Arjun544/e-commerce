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
    required this.orders,
  });

  bool success;
  List<Order> orders;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        success: json['success'],
        orders: List<Order>.from(json['orders'].map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'orders': List<dynamic>.from(orders.map((x) => x.toJson())),
      };
}

class Order {
  Order({
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
    required this.orderId,
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
  OrderUser user;
  DateTime dateOrdered;
  int v;
  String orderId;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
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
        user: OrderUser.fromJson(json['user']),
        dateOrdered: DateTime.parse(json['dateOrdered']),
        v: json['__v'],
        orderId: json['id'],
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
        'user': user.toJson(),
        'dateOrdered': dateOrdered.toIso8601String(),
        '__v': v,
        'id': orderId,
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
  OrderItemProduct product;
  int v;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json['_id'],
        quantity: json['quantity'],
        product: OrderItemProduct.fromJson(json['product']),
        v: json['__v'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'quantity': quantity,
        'product': product.toJson(),
        '__v': v,
      };
}

class OrderItemProduct {
  OrderItemProduct({
    required this.quantity,
    required this.fullDescription,
    required this.images,
    required this.price,
    required this.onSale,
    required this.totalPrice,
    required this.discount,
    required this.totalReviews,
    required this.reviews,
    required this.isReviewed,
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
  List<Review> reviews;
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
  String productId;

  factory OrderItemProduct.fromJson(Map<String, dynamic> json) =>
      OrderItemProduct(
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

  List<dynamic> subCategories;
  bool status;
  String id;
  String name;
  String icon;
  String iconId;
  int v;
  String categoryId;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        subCategories: List<dynamic>.from(json['subCategories'].map((x) => x)),
        status: json['status'],
        id: json['_id'],
        name: json['name'],
        icon: json['icon'],
        iconId: json['iconId'],
        v: json['__v'],
        categoryId: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'subCategories': List<dynamic>.from(subCategories.map((x) => x)),
        'status': status,
        '_id': id,
        'name': name,
        'icon': icon,
        'iconId': iconId,
        '__v': v,
        'id': categoryId,
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
  ReviewUser user;
  String review;
  double rating;
  ReviewProduct product;
  DateTime addedAt;
  int v;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json['_id'],
        user: ReviewUser.fromJson(json['user']),
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

class ReviewUser {
  ReviewUser({
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

  factory ReviewUser.fromJson(Map<String, dynamic> json) => ReviewUser(
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

class OrderUser {
  OrderUser({
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

  factory OrderUser.fromJson(Map<String, dynamic> json) => OrderUser(
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

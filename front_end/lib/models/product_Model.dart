// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);=
import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    required this.products,
  });

  List<Product> products;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        products: List<Product>.from(
            json['products'].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'products': List<dynamic>.from(products.map((x) => x.toJson())),
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
    required this.subCategory,
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
  Category category;
  int countInStock;
  DateTime dateCreated;
  int v;
  String subCategory;
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
        category: Category.fromJson(json['category']),
        countInStock: json['countInStock'],
        dateCreated: DateTime.parse(json['dateCreated']),
        v: json['__v'],
        subCategory: json['subCategory'],
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
        'category': category.toJson(),
        'countInStock': countInStock,
        'dateCreated': dateCreated.toIso8601String(),
        '__v': v,
        'subCategory': subCategory,
        'id': productId,
      };
}

class Category {
  Category({
    required this.subCategories,
    required this.id,
    required this.name,
    required this.icon,
    required this.v,
    required this.categoryId,
  });

  List<SubCategory> subCategories;
  String id;
  String name;
  String icon;
  int v;
  String categoryId;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        subCategories: List<SubCategory>.from(
            json['subCategories'].map((x) => SubCategory.fromJson(x))),
        id: json['_id'],
        name: json['name'],
        icon: json['icon'],
        v: json['__v'],
        categoryId: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'subCategories':
            List<dynamic>.from(subCategories.map((x) => x.toJson())),
        '_id': id,
        'name': name,
        'icon': icon,
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

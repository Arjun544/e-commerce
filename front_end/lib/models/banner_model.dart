// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromJson(jsonString);

import 'dart:convert';

import 'product_Model.dart';

BannerModel bannerModelFromJson(String str) =>
    BannerModel.fromJson(json.decode(str));

String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
  BannerModel({
    required this.success,
    required this.banners,
  });

  bool success;
  List<Banner> banners;

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        success: json['success'],
        banners:
            List<Banner>.from(json['banners'].map((x) => Banner.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'banners': List<dynamic>.from(banners.map((x) => x.toJson())),
      };
}

class Banner {
  Banner({
    required this.status,
    required this.products,
    required this.id,
    required this.image,
    required this.imageId,
    required this.type,
    required this.v,
    required this.bannerId,
  });

  bool status;
  List<Product> products;
  String id;
  String image;
  String imageId;
  String type;
  int v;
  String bannerId;

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        status: json['status'],
        products: List<Product>.from(json['products'].map((x) => Product.fromJson(x))),
        id: json['_id'],
        image: json['image'],
        imageId: json['imageId'],
        type: json['type'],
        v: json['__v'],
        bannerId: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'products': List<dynamic>.from(products.map((x) => x)),
        '_id': id,
        'image': image,
        'imageId': imageId,
        'type': type,
        '__v': v,
        'id': bannerId,
      };
}

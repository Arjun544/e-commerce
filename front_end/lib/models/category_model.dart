// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    required this.categoryList,
  });

  List<CategoryList> categoryList;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        categoryList: List<CategoryList>.from(
            json['categoryList'].map((x) => CategoryList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'categoryList': List<dynamic>.from(categoryList.map((x) => x.toJson())),
      };
}

class CategoryList {
  CategoryList({
    required this.subCategories,
    required this.status,
    required this.id,
    required this.name,
    required this.icon,
    required this.v,
    required this.categoryListId,
    required this.iconId,
  });

  List<SubCategory> subCategories;
  bool status;
  String id;
  String name;
  String icon;
  int v;
  String categoryListId;
  String iconId;

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
        subCategories: List<SubCategory>.from(
            json['subCategories'].map((x) => SubCategory.fromJson(x))),
        status: json['status'],
        id: json['_id'],
        name: json['name'],
        icon: json['icon'],
        v: json['__v'],
        categoryListId: json['id'],
        iconId: json['iconId'],
      );

  Map<String, dynamic> toJson() => {
        'subCategories':
            List<dynamic>.from(subCategories.map((x) => x.toJson())),
        'status': status,
        '_id': id,
        'name': name,
        'icon': icon,
        '__v': v,
        'id': categoryListId,
        'iconId': iconId,
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

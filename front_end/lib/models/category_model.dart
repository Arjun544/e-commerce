// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);
import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    required this.success,
    required this.categories,
  });

  bool success;
  List<Category> categories;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        success: json['success'],
        categories: List<Category>.from(
            json['categories'].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'categories': List<dynamic>.from(categories.map((x) => x.toJson())),
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

  List<dynamic> subCategories;
  String id;
  String name;
  String icon;
  int v;
  String categoryId;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        subCategories: List<dynamic>.from(json['subCategories'].map((x) => x)),
        id: json['_id'],
        name: json['name'],
        icon: json['icon'],
        v: json['__v'],
        categoryId: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'subCategories': List<dynamic>.from(subCategories.map((x) => x)),
        '_id': id,
        'name': name,
        'icon': icon,
        '__v': v,
        'id': categoryId,
      };
}

import 'package:flutter/material.dart';

class CategoryModel {
  String name;
  IconData icon;
  Color color;

  CategoryModel({required this.name, required this.icon, required this.color});
}

List<CategoryModel> categories = [
  CategoryModel(name: 'Men', icon: Icons.anchor, color: Colors.lightBlue),
  CategoryModel(name: 'Female', icon: Icons.anchor, color: Colors.orange),
  CategoryModel(name: 'Childern', icon: Icons.anchor, color: Colors.lightGreen),
  CategoryModel(name: 'Electronics', icon: Icons.anchor, color: Colors.purple),
  CategoryModel(name: 'Fashion', icon: Icons.anchor, color: Colors.lightBlue),
];

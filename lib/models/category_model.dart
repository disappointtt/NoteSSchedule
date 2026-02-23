import 'package:flutter/material.dart';

/// Модель данных для категории задачи
class CategoryModel {
  final String id;
  final String name;
  final Color color;
  final String icon;

  CategoryModel({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
  });

  // Конвертация в JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color.value,
      'icon': icon,
    };
  }

  // Создание из JSON
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'].toString(),
      name: json['name'].toString(),
      color: Color(int.parse(json['color'].toString())),
      icon: json['icon'].toString(),
    );
  }
}

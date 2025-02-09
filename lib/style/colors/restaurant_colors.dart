import 'package:flutter/material.dart';

enum RestaurantColors {
  blue("Blue", Color(0xFF1877F2)),;

  const RestaurantColors(this.name, this.color);

  final String name;
  final Color color;
}

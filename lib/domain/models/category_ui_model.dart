import 'package:flutter/material.dart';

class CategoryUiModel {
  final String title;
  final String description;
  final double angle;
  final Color color;
  bool hovered;
  final Widget mobileIcon;
  final Widget webIcon;

  CategoryUiModel({
    required this.title,
    required this.description,
    required this.angle,
    required this.color,
    required this.hovered,
    required this.mobileIcon,
    required this.webIcon,
  });
}

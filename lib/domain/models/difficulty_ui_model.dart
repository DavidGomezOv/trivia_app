import 'package:flutter/material.dart';

class DifficultyUiModel {
  final String title;
  final String description;
  final int questionsQuantity;
  final int timePerQuestion;
  final Color backgroundColor;
  final int starts;

  DifficultyUiModel({
    required this.title,
    required this.description,
    required this.questionsQuantity,
    required this.timePerQuestion,
    required this.backgroundColor,
    required this.starts,
  });
}

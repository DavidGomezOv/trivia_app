import 'package:flutter/material.dart';

extension Dimensions on BuildContext {
  bool isMobile() => MediaQuery.sizeOf(this).width < 630;
}

extension Category on String {
  String categoryId() {
    switch (toLowerCase()) {
      case 'sports':
        return '21';
      case 'movies':
        return '11';
      case 'science':
        return '17';
      case 'history':
        return '23';
      case 'geography':
        return '22';
      case 'computers':
        return '18';
      default:
        return '0';
    }
  }
}

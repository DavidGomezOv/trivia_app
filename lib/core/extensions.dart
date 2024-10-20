import 'package:flutter/material.dart';

extension Dimensions on BuildContext {
  bool isMobile() => MediaQuery.sizeOf(this).width < 630;
}

extension Category on String {
  String categoryId() {
    switch (toLowerCase()) {
      case 'sports':
        return '21';
      case 'art':
        return '25';
      case 'animals':
        return '27';
      case 'history':
        return '23';
      case 'geography':
        return '22';
      case 'mythology':
        return '20';
      default:
        return '0';
    }
  }
}

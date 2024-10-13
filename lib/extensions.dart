import 'package:flutter/material.dart';

extension Dimensions on BuildContext {
  bool isMobile() => MediaQuery.sizeOf(this).width < 630;
}

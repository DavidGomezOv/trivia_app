import 'package:flutter/material.dart';
import 'package:trivia_app/theme/custom_colors.dart';

class ButtonStyles {
  static ButtonStyle primaryButton(BuildContext context) {
    return ButtonStyle(
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      backgroundColor: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.hovered)) {
            return CustomColors.primaryHovered;
          }
          if (states.contains(WidgetState.disabled)) {
            return CustomColors.tertiary;
          }
          return Theme.of(context).primaryColor;
        },
      ),
      elevation: WidgetStateProperty.all(6),
      padding: WidgetStateProperty.all(const EdgeInsets.all(20)),
    );
  }

  static ButtonStyle categoryButton(BuildContext context) {
    return ButtonStyle(
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      backgroundColor: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.hovered)) {
            return CustomColors.primaryHovered;
          }
          return CustomColors.greenButton;
        },
      ),
      elevation: WidgetStateProperty.all(6),
      padding: WidgetStateProperty.all(EdgeInsets.zero),
    );
  }
}

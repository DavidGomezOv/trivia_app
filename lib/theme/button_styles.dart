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
          return Theme.of(context).primaryColor;
        },
      ),
      elevation: WidgetStateProperty.all(6),
      foregroundColor: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.disabled)) {
            return Theme.of(context).colorScheme.secondary;
          }
          return Theme.of(context).primaryColor;
        },
      ),
      padding: WidgetStateProperty.all(const EdgeInsets.all(20)),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:trivia_app/theme/custom_colors.dart';

class ErrorStateWidget extends StatelessWidget {
  const ErrorStateWidget({
    super.key,
    required this.errorMessage,
  });

  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('icons/error_icon.png', height: 200),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Oops!! ',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: CustomColors.greenText),
                children: [
                  TextSpan(
                    text: errorMessage ?? 'An error occurred, please try again.',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 24),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

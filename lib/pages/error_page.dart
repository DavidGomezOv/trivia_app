import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    super.key,
    this.errorMessage,
  });

  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorMessage ?? 'Error, please try again.',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}

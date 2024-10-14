import 'package:flutter/material.dart';
import 'package:trivia_app/presentation/widgets/app_background_widget.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({super.key, required this.child, required this.backButton});

  final Widget child;
  final Widget backButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: AppBackgroundWidget(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                Align(alignment: Alignment.topLeft, child: backButton),
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: child,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

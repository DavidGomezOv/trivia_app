import 'package:flutter/material.dart';
import 'package:trivia_app/core/extensions.dart';
import 'package:trivia_app/presentation/widgets/app_background_widget.dart';
import 'package:trivia_app/theme/button_styles.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    super.key,
    required this.child,
    this.onBackPressed,
    this.header,
    this.width,
  });

  final Widget child;
  final VoidCallback? onBackPressed;
  final Widget? header;
  final double? width;

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
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 20,
                      left: 10,
                      bottom: context.isMobile() ? 20 : 0,
                    ),
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        if (onBackPressed != null)
                          SizedBox(
                            width: context.isMobile() ? 50 : 60,
                            height: context.isMobile() ? 50 : 60,
                            child: ElevatedButton(
                              style: ButtonStyles.primaryButton(context)
                                  .copyWith(padding: const WidgetStatePropertyAll(EdgeInsets.zero)),
                              onPressed: onBackPressed,
                              child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 40),
                            ),
                          ),
                        if (header != null) header!,
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: width,
                    child: CustomScrollView(
                      slivers: [
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: child,
                        ),
                      ],
                    ),
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

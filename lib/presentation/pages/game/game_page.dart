import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trivia_app/extensions.dart';
import 'package:trivia_app/presentation/widgets/base_scaffold.dart';
import 'package:trivia_app/routes/app_router.dart';
import 'package:trivia_app/theme/button_styles.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backButton: Container(
        width: 60,
        height: 60,
        margin: EdgeInsets.only(top: 20, left: 10, bottom: context.isMobile() ? 30 : 0),
        child: ElevatedButton(
          style: ButtonStyles.primaryButton(context)
              .copyWith(padding: const WidgetStatePropertyAll(EdgeInsets.zero)),
          onPressed: () => context.goNamed(AppRouter.menuRouteData.name),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
      child: Placeholder(),
    );
  }
}

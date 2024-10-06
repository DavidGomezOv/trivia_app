import 'package:flutter/material.dart';
import 'package:trivia_app/routes/app_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.generateAppRouter(context),
      onGenerateTitle: (context) => 'Trivia App',
      theme: ThemeData(fontFamily: 'Rubik'),
    );
  }
}

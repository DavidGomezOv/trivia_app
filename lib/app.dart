import 'package:flutter/material.dart';
import 'package:trivia_app/data/api/questions_api.dart';
import 'package:trivia_app/data/api_client.dart';
import 'package:trivia_app/data/repositories/questions_repository.dart';
import 'package:trivia_app/domain/irepositories/i_questions_repository.dart';
import 'package:trivia_app/routes/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_app/theme/custom_colors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<IQuestionsRepository>(
          create: (context) => QuestionsRepository(questionsApi: QuestionsApi(ApiClient())),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.generateAppRouter(context),
        onGenerateTitle: (context) => 'Trivia App',
        theme: ThemeData(
          primaryColor: CustomColors.primary,
          colorScheme: ColorScheme.light(
            primary: CustomColors.primary,
            secondary: CustomColors.secondary,
            tertiary: CustomColors.tertiary,
            surface: CustomColors.surface,
          ),
          textTheme: TextTheme(
            displayLarge: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontFamily: 'Rubik',
                  color: Colors.white,
                  letterSpacing: 2,
                  fontVariations: [const FontVariation('wght', 900)],
                  fontSize: 60,
                ),
            displaySmall: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontFamily: 'Rubik',
                  color: Colors.white,
                  letterSpacing: 2,
                  fontVariations: [const FontVariation('wght', 800)],
                  fontSize: 38,
                ),
            headlineSmall: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontFamily: 'Rubik',
                  color: Colors.white,
                  fontVariations: [const FontVariation('wght', 700)],
                  fontSize: 24,
                ),
          ),
        ),
      ),
    );
  }
}

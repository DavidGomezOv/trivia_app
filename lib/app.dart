import 'package:flutter/material.dart';
import 'package:trivia_app/core/extensions.dart';
import 'package:trivia_app/data/api/game_api.dart';
import 'package:trivia_app/data/api_client.dart';
import 'package:trivia_app/data/repositories/game_repository.dart';
import 'package:trivia_app/domain/irepositories/i_game_repository.dart';
import 'package:trivia_app/presentation/pages/game/cubit/game_cubit.dart';
import 'package:trivia_app/routes/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_app/theme/custom_colors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<IGameRepository>(
      create: (context) => GameRepository(
        questionsApi: GameApi(
          ApiClient(),
        ),
      ),
      child: BlocProvider<GameCubit>(
        create: (context) => GameCubit(
          questionsRepository: context.read<IGameRepository>(),
        ),
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
              titleSmall: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontFamily: 'Rubik',
                    color: Colors.white,
                    fontVariations: [const FontVariation('wght', 500)],
                    fontSize: 18,
                  ),
              bodyMedium: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontFamily: 'Rubik',
                    color: Colors.white,
                    fontVariations: [const FontVariation('wght', 400)],
                    fontSize: 16,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}

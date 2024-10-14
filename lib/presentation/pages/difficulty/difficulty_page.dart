import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trivia_app/extensions.dart';
import 'package:trivia_app/presentation/pages/difficulty/cubit/difficulty_cubit.dart';
import 'package:trivia_app/presentation/widgets/base_scaffold.dart';
import 'package:trivia_app/routes/app_router.dart';
import 'package:trivia_app/theme/button_styles.dart';
import 'package:trivia_app/theme/custom_colors.dart';

class DifficultyPage extends StatelessWidget {
  const DifficultyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DifficultyCubit(),
      child: BaseScaffold(
        backButton: Container(
          width: 60,
          height: 60,
          margin: EdgeInsets.only(top: 20, left: 10, bottom: context.isMobile() ? 30 : 0),
          child: ElevatedButton(
            style: ButtonStyles.primaryButton(context)
                .copyWith(padding: const WidgetStatePropertyAll(EdgeInsets.zero)),
            onPressed: () => context.goNamed(AppRouter.categoryRouteData.name),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      style: ButtonStyles.primaryButton(context),
                      onPressed: () {},
                      child: Text(
                        'Easy',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      style: ButtonStyles.primaryButton(context),
                      onPressed: () {},
                      child: Text(
                        'Medium',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      style: ButtonStyles.primaryButton(context),
                      onPressed: () {},
                      child: Text(
                        'Hard',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            BlocBuilder<DifficultyCubit, DifficultyState>(
              builder: (context, state) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    state.selectedDifficulty?.title ?? 'Select Difficulty',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: state.selectedDifficulty == null
                              ? Colors.white
                              : CustomColors.greenText,
                          fontSize: state.selectedDifficulty == null ? 38 : 46,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    state.selectedDifficulty?.description ??
                        'Click on any roulette section to continue.',
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  if (state.selectedDifficulty != null)
                    ElevatedButton(
                      style: ButtonStyles.primaryButton(context),
                      onPressed: () {},
                      child: Text(
                        'Select',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

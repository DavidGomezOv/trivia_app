import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trivia_app/extensions.dart';
import 'package:trivia_app/presentation/pages/category/cubit/category_cubit.dart';
import 'package:trivia_app/presentation/pages/category/widgets/category_button_widget.dart';
import 'package:trivia_app/presentation/widgets/base_scaffold.dart';
import 'package:trivia_app/routes/app_router.dart';
import 'package:trivia_app/theme/button_styles.dart';
import 'package:trivia_app/theme/custom_colors.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryCubit(),
      child: BaseScaffold(
        backButton: Container(
          width: 60,
          height: 60,
          margin: EdgeInsets.only(top: 20, left: 10, bottom: context.isMobile() ? 30 : 0),
          child: ElevatedButton(
            style: ButtonStyles.primaryButton(context)
                .copyWith(padding: const WidgetStatePropertyAll(EdgeInsets.zero)),
            onPressed: () => context.goNamed(AppRouter.menuRouteData.name),
            child: const Icon(Icons.home_rounded, color: Colors.white, size: 40),
          ),
        ),
        child: BlocBuilder<CategoryCubit, CategoryState>(
          buildWhen: (previous, current) =>
              previous.hoveredCategory != current.hoveredCategory ||
              previous.selectedCategory != current.selectedCategory,
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ...List.generate(
                        6,
                        (index) => CategoryButton(
                          category: state.categories[index],
                          hovered: state.categories[index] == state.hoveredCategory,
                          selected: state.categories[index] == state.selectedCategory,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.isMobile() ? 20 : 40),
                Text(
                  state.selectedCategory?.title ?? 'Select Category',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color:
                            state.selectedCategory == null ? Colors.white : CustomColors.greenText,
                        fontSize: state.selectedCategory == null ? 38 : 46,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                Text(
                  state.selectedCategory?.description ??
                      'Click on any roulette section to continue.',
                  style: Theme.of(context).textTheme.titleSmall,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: context.isMobile() ? 10 : 30),
                if (state.selectedCategory != null)
                  ElevatedButton(
                    style: ButtonStyles.primaryButton(context),
                    onPressed: () => context.goNamed(AppRouter.difficultyRouteData.name),
                    child: Text(
                      'Select',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                const SizedBox(height: 30),
              ],
            );
          },
        ),
      ),
    );
  }
}

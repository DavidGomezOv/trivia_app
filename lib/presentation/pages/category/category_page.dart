import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trivia_app/core/extensions.dart';
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
    return BlocProvider<CategoryCubit>(
      create: (context) => CategoryCubit(),
      child: BaseScaffold(
        onBackPressed: () => context.goNamed(AppRouter.menuRouteData.name),
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
                          isHovered: state.categories[index] == state.hoveredCategory,
                          isSelected: state.categories[index] == state.selectedCategory,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.isMobile() ? 20 : 30),
                Text(
                  state.selectedCategory?.title ??
                      state.hoveredCategory?.title ??
                      'Select Category',
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
                SizedBox(height: context.isMobile() ? 10 : 20),
                if (state.selectedCategory != null)
                  ElevatedButton(
                    style: ButtonStyles.primaryButton(context),
                    onPressed: () => context.goNamed(
                      AppRouter.difficultyRouteData.name,
                      queryParameters: {'category': state.selectedCategory!.title},
                    ),
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

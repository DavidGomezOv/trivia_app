import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_app/domain/models/category_ui_model.dart';
import 'package:trivia_app/core/extensions.dart';
import 'package:trivia_app/presentation/pages/category/cubit/category_cubit.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    super.key,
    required this.category,
    required this.isHovered,
    required this.isSelected,
  });

  final CategoryUiModel category;
  final bool isHovered;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: context.isMobile() ? 320 : 450,
      height: context.isMobile() ? 320 : 450,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 150),
        scale: isHovered || isSelected ? 1.12 : 1,
        child: ClipPath(
          clipper: _ButtonClipper(angle: category.angle),
          child: Stack(
            alignment: Alignment.center,
            children: [
              MouseRegion(
                onEnter: (event) {
                  context.read<CategoryCubit>().updateCategoryHovered(
                        categoryHovered: category,
                      );
                },
                onExit: (event) {
                  context.read<CategoryCubit>().updateCategoryHovered(
                        categoryHovered: category,
                        hovered: false,
                      );
                },
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => context.read<CategoryCubit>().updateSelectedCategory(
                        selectedCategory: category,
                      ),
                  child: Container(color: category.color),
                ),
              ),
              context.isMobile() ? category.mobileIcon : category.webIcon,
            ],
          ),
        ),
      ),
    );
  }
}

class _ButtonClipper extends CustomClipper<Path> {
  _ButtonClipper({required this.angle});

  final double angle;

  @override
  Path getClip(Size size) {
    const double sweepAngle = pi / 3;
    double startAngle = pi / angle;

    Path path = Path()
      ..lineTo(size.width / 2, size.height / 2)
      ..arcTo(
        Rect.fromLTWH(0, 0, size.width, size.height),
        startAngle,
        sweepAngle,
        true,
      )
      ..lineTo(size.width / 2, size.height / 2);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

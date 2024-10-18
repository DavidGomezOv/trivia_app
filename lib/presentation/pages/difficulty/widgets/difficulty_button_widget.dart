import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_app/domain/models/difficulty_ui_model.dart';
import 'package:trivia_app/extensions.dart';
import 'package:trivia_app/presentation/pages/difficulty/cubit/difficulty_cubit.dart';

class DifficultyButtonWidget extends StatefulWidget {
  const DifficultyButtonWidget({super.key, required this.difficulty, required this.isSelected});

  final DifficultyUiModel difficulty;
  final bool isSelected;

  @override
  State<DifficultyButtonWidget> createState() => _DifficultyButtonWidgetState();
}

class _DifficultyButtonWidgetState extends State<DifficultyButtonWidget> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 150),
      scale: _hovered || widget.isSelected ? 1.1 : 1,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (event) => setState(() {
          _hovered = true;
        }),
        onExit: (event) => setState(() {
          _hovered = false;
        }),
        child: GestureDetector(
          onTap: () => context.read<DifficultyCubit>().updateSelectedDifficulty(
                selectedDifficulty: widget.difficulty,
              ),
          child: SizedBox(
            width: 280,
            height: context.isMobile() ? 100 : 130,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 250,
                  height: context.isMobile() ? 60 : 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: widget.difficulty.backgroundColor,
                  ),
                  child: Center(
                    child: Text(
                      widget.difficulty.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      widget.difficulty.starts,
                      (index) => const Icon(
                        Icons.star,
                        size: 50,
                        color: Colors.amberAccent,
                        shadows: [Shadow(color: Colors.black, blurRadius: 20.0)],
                      ),
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

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trivia_app/theme/button_styles.dart';

class CategoryButtonWidget extends StatelessWidget {
  const CategoryButtonWidget({
    super.key,
    required this.iconName,
    required this.buttonLabel,
    required this.onPressed,
  });

  final String iconName;
  final String buttonLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0, .7, 1],
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(.4),
                Colors.black.withOpacity(.7)
              ],
            ).createShader(
              Rect.fromLTRB(0, 0, rect.width, rect.height),
            );
          },
          blendMode: BlendMode.srcATop,
          child: ElevatedButton(
            style: ButtonStyles.categoryButton(context),
            onPressed: onPressed,
            child: Center(
              child: SvgPicture.asset(
                'icons/$iconName.svg',
                height: 120,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Positioned(
            bottom: 10,
            child: Text(
              buttonLabel,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(height: 1),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

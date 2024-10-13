import 'dart:math';

import 'package:flutter/material.dart';

class AppBackgroundWidget extends StatelessWidget {
  const AppBackgroundWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Stack(
        children: [
          Positioned(
            bottom: -70,
            left: -30,
            child: Transform.rotate(
              angle: -pi / 3,
              origin: const Offset(-1, 50),
              child: Icon(
                Icons.question_mark_sharp,
                size: 300,
                color: Colors.white.withOpacity(.08),
              ),
            ),
          ),
          Positioned(
            bottom: -60,
            left: MediaQuery.sizeOf(context).width / 2 - 200,
            child: Transform.rotate(
              angle: pi / 30,
              child: Icon(
                Icons.question_mark_sharp,
                size: 400,
                color: Colors.white.withOpacity(.09),
              ),
            ),
          ),
          Positioned(
            bottom: -20,
            right: -5,
            child: Transform.rotate(
              angle: pi / 3,
              origin: const Offset(-1, 50),
              child: Icon(
                Icons.question_mark_sharp,
                size: 150,
                color: Colors.white.withOpacity(.12),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.sizeOf(context).height / 2 - 100,
            right: -70,
            child: Transform.rotate(
              angle: -pi / 1.3,
              origin: const Offset(-1, 50),
              child: Icon(
                Icons.question_mark_sharp,
                size: 120,
                color: Colors.white.withOpacity(.07),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.sizeOf(context).height / 2 - 100,
            left: -70,
            child: Transform.rotate(
              angle: pi / 1.6,
              origin: const Offset(-1, 50),
              child: Icon(
                Icons.question_mark_sharp,
                size: 120,
                color: Colors.white.withOpacity(.18),
              ),
            ),
          ),
          Positioned(
            top: -70,
            left: -100,
            child: Transform.rotate(
              angle: pi / 3,
              origin: const Offset(-1, 50),
              child: Icon(
                Icons.question_mark_sharp,
                size: 250,
                color: Colors.white.withOpacity(.08),
              ),
            ),
          ),
          Positioned(
            top: -60,
            left: MediaQuery.sizeOf(context).width / 2 - 200,
            child: Transform.rotate(
              angle: -pi / 1.1,
              child: Icon(
                Icons.question_mark_sharp,
                size: 400,
                color: Colors.white.withOpacity(.09),
              ),
            ),
          ),
          Positioned(
            top: -50,
            right: -80,
            child: Transform.rotate(
              angle: -pi / 3,
              origin: const Offset(-1, 50),
              child: Icon(
                Icons.question_mark_sharp,
                size: 150,
                color: Colors.white.withOpacity(.12),
              ),
            ),
          ),
          child
        ],
      ),
    );
  }
}

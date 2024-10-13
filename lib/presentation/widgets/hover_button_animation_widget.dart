import 'package:flutter/material.dart';

class HoverButtonAnimationWidget extends StatefulWidget {
  const HoverButtonAnimationWidget({super.key, required this.child});

  final Widget child;

  @override
  State<HoverButtonAnimationWidget> createState() => _HoverButtonAnimationWidgetState();
}

class _HoverButtonAnimationWidgetState extends State<HoverButtonAnimationWidget> {
  final hoveredTransform = Matrix4.identity()..translate(0, -4);
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => onEntered(true),
      onExit: (event) => onEntered(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: isHovered ? hoveredTransform : Matrix4.identity(),
        child: widget.child,
      ),
    );
  }

  void onEntered(bool isHovered) => setState(() {
        this.isHovered = isHovered;
      });
}

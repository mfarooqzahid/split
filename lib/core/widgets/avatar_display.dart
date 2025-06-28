import 'package:flutter/material.dart';

class AvatarDisplay extends StatelessWidget {
  final Widget? child;
  const AvatarDisplay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: ColoredBox(
        color: Colors.grey.withAlpha(30),
        child: SizedBox.square(
          dimension: 100,
          child: child,
        ),
      ),
    );
  }
}

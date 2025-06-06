import 'package:flutter/material.dart';

class DefaultStyledContainer extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final Widget child;
  const DefaultStyledContainer({super.key, required this.child, this.margin});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      margin: margin,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}

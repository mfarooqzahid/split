import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final double size;
  const LoadingIndicator({super.key, this.size = 50});

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: CircularProgressIndicator(
        strokeCap: StrokeCap.round,
        strokeWidth: 2,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

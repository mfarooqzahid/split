import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomSheetPopup extends StatefulWidget {
  final VoidCallback onClosed;
  final String title;
  final Widget child;
  const BottomSheetPopup({
    super.key,
    required this.onClosed,
    required this.title,
    required this.child,
  });

  @override
  State<BottomSheetPopup> createState() => _BottomSheetPopupState();
}

class _BottomSheetPopupState extends State<BottomSheetPopup> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedPadding(
      padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom),
      duration: Durations.short4,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 6,
          children: [
            Row(
              children: [
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.title,
                    style: theme.textTheme.bodyLarge!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton.filledTonal(
                  padding: EdgeInsets.zero,
                  splashRadius: 12,
                  constraints: const BoxConstraints(
                    minWidth: 24,
                    minHeight: 24,
                  ),
                  onPressed: widget.onClosed,
                  icon: const Icon(CupertinoIcons.multiply, size: 16),
                ),
              ],
            ),
            // add the child from parameter
            widget.child
          ],
        ),
      ),
    );
  }
}

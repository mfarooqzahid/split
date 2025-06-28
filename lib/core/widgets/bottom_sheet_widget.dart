import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomSheetWidget extends StatelessWidget {
  final VoidCallbackAction? onClose;
  final String title;
  final Widget child;
  const BottomSheetWidget({
    super.key,
    this.onClose,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedPadding(
      duration: Durations.short4,
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(12),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.bodyLarge!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  splashRadius: 12,
                  constraints: const BoxConstraints(
                    minWidth: 24,
                    minHeight: 24,
                  ),
                  onPressed: () => onClose ?? context.pop(),
                  icon: const Icon(Icons.close, size: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // child at the end
            child,

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

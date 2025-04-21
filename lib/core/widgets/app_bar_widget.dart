import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final String? title;
  final List<Widget>? actions;
  const AppBarWidget({
    super.key,
    this.leading,
    this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          spacing: 8,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: leading ??
                    IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: const Icon(CupertinoIcons.back),
                    ),
              ),
            ),
            Expanded(
                child: Align(
              child: SizedBox(
                  child: Text(
                title ?? "",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              )),
            )),
            Expanded(
              child: Row(
                spacing: 4,
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions ?? [],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

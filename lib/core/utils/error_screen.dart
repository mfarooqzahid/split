import 'package:flutter/material.dart';
import 'package:split/core/assets/images.dart';
import '/l10n/app_localizations.dart';

class ErrorScreen extends StatelessWidget {
  final String? title;
  final String? message;

  const ErrorScreen({
    super.key,
    this.title,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SVG Illustration
              Image.asset(
                AppImages.bugFixing,
                height: 200,
                width: 200,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 32),

              // Error Title
              Text(
                title ?? localization.errorTitle,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // Error Message
              Text(
                message ?? localization.errorMessage,
                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

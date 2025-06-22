import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/l10n/app_localizations.dart';
import 'package:split/core/widgets/default_styled_container.dart';

class RecentBillCard extends StatelessWidget {
  final String title;
  final DateTime date;
  final double amount;
  final List<Color> colors;
  final int totalPersons;

  const RecentBillCard({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    required this.colors,
    required this.totalPersons,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = AppLocalizations.of(context)!;

    return DefaultStyledContainer(
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey.withAlpha(30),
                radius: 20,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodyLarge!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(DateFormat.MMMEd().format(date)),
                ],
              ),
              const Spacer(),
              Text(
                amount.toStringAsFixed(2),
                style: theme.textTheme.bodyLarge!.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            spacing: 4,
            children: [
              ...colors.take(3).map(
                    (color) => CircleAvatar(
                      radius: 16,
                      backgroundColor: color,
                    ),
                  ),
              if (totalPersons > 3)
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.grey.withAlpha(30),
                  child: Text(
                    "+${totalPersons - 3}",
                    style: theme.textTheme.titleLarge!.copyWith(
                      fontSize: 12,
                    ),
                  ),
                ),
              const Spacer(),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "${localization.sharing}: ",
                      style: theme.textTheme.bodyMedium!.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: "$totalPersons ${localization.persons}",
                      style: theme.textTheme.titleLarge!.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

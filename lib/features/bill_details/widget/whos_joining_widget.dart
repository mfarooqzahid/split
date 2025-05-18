import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:split/core/widgets/default_styled_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WhosJoiningWidget extends StatefulWidget {
  final List<String> members;
  final ValueChanged<List<String>> seletedMembers;
  const WhosJoiningWidget({
    super.key,
    required this.members,
    required this.seletedMembers,
  });

  @override
  State<WhosJoiningWidget> createState() => _WhosJoiningWidgetState();
}

class _WhosJoiningWidgetState extends State<WhosJoiningWidget> {
  final List<String> membersJoined = [];
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return DefaultStyledContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4,
        children: [
          Text(
            localization.whosJoiningTheSplit,
            style: theme.textTheme.bodyLarge!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          ...List.from(widget.members).map(
            (e) {
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                onTap: () {
                  setState(() {
                    membersJoined.contains(e)
                        ? membersJoined.remove(e)
                        : membersJoined.add(e);
                  });
                  widget.seletedMembers(membersJoined);
                },
                title: Text(e),
                leading: CircleAvatar(
                  backgroundColor: Colors.grey.withAlpha(30),
                ),
                trailing: membersJoined.contains(e)
                    ? Icon(
                        CupertinoIcons.check_mark_circled_solid,
                        color: theme.colorScheme.primary,
                      )
                    : const Icon(CupertinoIcons.circle),
              );
            },
          )
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:split/core/widgets/default_styled_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WhosPayingWidget extends StatefulWidget {
  final List<String> members;
  final Function(String m) onSelected;
  const WhosPayingWidget(
      {super.key, required this.members, required this.onSelected});

  @override
  State<WhosPayingWidget> createState() => _WhosPayingWidgetState();
}

class _WhosPayingWidgetState extends State<WhosPayingWidget> {
  bool isExpanded = false;

  late String whosPaying;

  @override
  void initState() {
    whosPaying = widget.members.first;
    widget.onSelected(whosPaying);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return DefaultStyledContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localization.whosPaying,
            style: theme.textTheme.bodyLarge!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          ExpansionPanelList(
            expandedHeaderPadding: EdgeInsets.zero,
            children: [
              ExpansionPanel(
                  isExpanded: isExpanded,
                  canTapOnHeader: true,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                      title: Text(whosPaying),
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey.withAlpha(30),
                      ),
                    );
                  },
                  body: Column(
                    children: [
                      ...List.generate(
                        widget.members.length,
                        (index) {
                          return ListTile(
                            onTap: () {
                              setState(() {
                                whosPaying = widget.members[index];
                                isExpanded = false;
                              });
                              widget.onSelected(whosPaying);
                            },
                            title: Text(widget.members[index]),
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey.withAlpha(30),
                            ),
                            trailing: widget.members[index] == whosPaying
                                ? Icon(
                                    CupertinoIcons.checkmark_circle_fill,
                                    color: theme.primaryColor,
                                  )
                                : null,
                          );
                        },
                      )
                    ],
                  )),
            ],
            elevation: 0,
            expansionCallback: (panelIndex, isExpanded) {
              setState(() {
                this.isExpanded = isExpanded;
              });
            },
          )
        ],
      ),
    );
  }
}

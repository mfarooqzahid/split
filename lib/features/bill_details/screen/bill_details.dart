import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/l10n/app_localizations.dart';
import 'package:split/core/utils/emoji_matcher.dart';
import 'package:split/core/widgets/default_styled_container.dart';
import 'package:split/features/bill_details/models/bill_details_model.dart';
import 'package:split/features/bill_details/widget/whos_joining_widget.dart';
import 'package:split/features/bill_details/widget/whos_paying.dart';

class BillDetailsScreen extends StatefulWidget {
  final double amount;
  const BillDetailsScreen({super.key, required this.amount});

  @override
  State<BillDetailsScreen> createState() => _BillDetailsScreenState();
}

class _BillDetailsScreenState extends State<BillDetailsScreen> {
  List<String> dummyMembers = ["Ali", "Farooq", "Zain", "Hassan", "Ayesha"];

  final List<String> membersJoined = [];
  late String whosPaying;

  late EmojiMatcher emojiMatcher;
  late ValueNotifier<String> matchedEmoji;

  final billNameController = TextEditingController();

  @override
  void initState() {
    emojiMatcher = EmojiMatcher();
    matchedEmoji = ValueNotifier(emojiMatcher.findClosestMatch(
      billNameController.text.trim(),
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          localization.billDetails,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyLarge!.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton.filled(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.refresh),
          ),
        ],
      ),
      body: NotificationListener(
        onNotification: (OverscrollIndicatorNotification notification) {
          notification.disallowIndicator();
          return true;
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4.0),
            child: Column(
              spacing: 8,
              children: [
                DefaultStyledContainer(
                  child: Column(
                    spacing: 6,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localization.billName,
                        style: theme.textTheme.bodyLarge!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextField(
                        autofocus: true,
                        controller: billNameController,
                        cursorOpacityAnimates: true,
                        cursorRadius: const Radius.circular(12),
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          hintText: localization.egEggs,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(4),
                            child: ValueListenableBuilder(
                                valueListenable: matchedEmoji,
                                builder: (context, value, child) {
                                  return CircleAvatar(
                                    backgroundColor: Colors.grey.withAlpha(30),
                                    child: Text(value),
                                  );
                                }),
                          ),
                        ),
                        onChanged: (value) {
                          matchedEmoji.value = emojiMatcher
                              .findClosestMatch(billNameController.text.trim());
                        },
                      ),
                    ],
                  ),
                ),
                WhosPayingWidget(
                  members: dummyMembers,
                  onSelected: (whosPaying) {
                    this.whosPaying = whosPaying;
                  },
                ),
                WhosJoiningWidget(
                  members: dummyMembers,
                  seletedMembers: (membersJoined) {
                    this.membersJoined
                      ..clear()
                      ..addAll(membersJoined);
                  },
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FilledButton.icon(
          style: FilledButton.styleFrom(
            fixedSize: const Size.fromHeight(50),
          ),
          onPressed: () {
            context.goNamed("confirmbill",
                extra: BillDetailsModel(
                  billName: billNameController.text.trim(),
                  amount: widget.amount,
                  members: membersJoined,
                  whosPaying: whosPaying,
                ));
          },
          label: const Text("Continue"),
        ),
      ),
    );
  }
}

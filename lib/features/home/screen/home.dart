import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:split/core/widgets/default_styled_container.dart';
import 'package:split/features/home/widget/drawer.dart';
import 'package:split/features/home/widget/recent_bill_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    // //setStatusBarColor(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: const HomeDrawer(),
      // appbar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: SafeArea(
          top: true,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  // open drawer
                  _scaffoldKey.currentState?.openDrawer();
                },
                icon: const Icon(CupertinoIcons.line_horizontal_3),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.search),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.bell),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: NotificationListener(
          onNotification: (OverscrollIndicatorNotification notification) {
            notification.disallowIndicator();
            return true;
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  // wellcome card
                  DefaultStyledContainer(
                    child: Column(
                      spacing: 4,
                      children: [
                        Text(
                          "${localization.welcomeback},👋 Farooq!",
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          localization.yourTotalBalance,
                          style: theme.textTheme.bodyLarge!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "-430.00",
                          style: theme.textTheme.titleLarge!.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // recent bills
                  Text(
                    localization.recentbills,
                    style: theme.textTheme.bodyLarge!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  ...List.generate(
                    10,
                    (index) => RecentBillCard(
                      title: "Dinner Date",
                      date: DateTime.now(),
                      amount: 180.00,
                      colors: colors,
                      totalPersons: 5 + index,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(CupertinoIcons.add),
        onPressed: () {
          context.goNamed('amountkeypad');
        },
        label: Text(
          localization.addBill,
        ),
      ),
    );
  }
}

final colors = [Colors.amber, Colors.deepOrange, Colors.blue];

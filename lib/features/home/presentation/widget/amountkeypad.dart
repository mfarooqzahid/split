import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '/l10n/app_localizations.dart';
import 'package:split/core/utils/logger.dart';

class Amountkeypad extends StatefulWidget {
  const Amountkeypad({super.key});

  @override
  State<Amountkeypad> createState() => _AmountkeypadState();
}

class _AmountkeypadState extends State<Amountkeypad> {
  final enteredAmount = ValueNotifier("");
  final amountController = TextEditingController();

  void handleKeyTap(String value) {
    if (value == "backspace") {
      if (enteredAmount.value.isNotEmpty) {
        enteredAmount.value =
            enteredAmount.value.substring(0, enteredAmount.value.length - 1);
      }
    } else if (value == "confirm") {
      Logger.log(enteredAmount.value);
      if (enteredAmount.value.isNotEmpty) {
        context.goNamed('billdetails', extra: enteredAmount.value);
      }
    } else {
      int newAmount = int.tryParse(enteredAmount.value + value) ?? 0;
      if (!(enteredAmount.value.isEmpty && value == "0") &&
          newAmount <= 100000) {
        enteredAmount.value += value;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
        backgroundColor: theme.colorScheme.primary,
        appBar: AppBar(
          centerTitle: true,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark,
          ),
          backgroundColor: Colors.transparent,
          leading: IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              context.pop();
            },
            icon: const Icon(CupertinoIcons.back),
          ),
          title: Text(
            localization.amount,
            style: TextStyle(
              color: theme.colorScheme.onPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: ValueListenableBuilder(
                    valueListenable: enteredAmount,
                    builder: (context, value, child) {
                      return Text(
                        textAlign: TextAlign.center,
                        "RS. ${value.isEmpty ? "0" : value}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onPrimary,
                          fontSize: 40,
                        ),
                      );
                    }),
              ),
            ),
            GridView.count(
              padding: const EdgeInsets.all(10),
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: _keys.map((key) {
                return GestureDetector(
                  onTap: () => handleKeyTap(key["value"]),
                  child: Container(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      key["label"],
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ));
  }
}

final List<Map<String, dynamic>> _keys = [
  {"label": "1", "value": "1"},
  {"label": "2", "value": "2"},
  {"label": "3", "value": "3"},
  {"label": "4", "value": "4"},
  {"label": "5", "value": "5"},
  {"label": "6", "value": "6"},
  {"label": "7", "value": "7"},
  {"label": "8", "value": "8"},
  {"label": "9", "value": "9"},
  {"label": "⌫", "value": "backspace"}, // Backspace action
  {"label": "0", "value": "0"},
  {"label": "✓", "value": "confirm"}, // Confirm action
];

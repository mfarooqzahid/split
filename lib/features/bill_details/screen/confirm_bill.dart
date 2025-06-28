import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:split/core/utils/logger.dart';
import '../models/bill_details_model.dart';
import '/l10n/app_localizations.dart';

class ConfirmBillScreen extends StatefulWidget {
  final BillDetailsModel billDetails;
  const ConfirmBillScreen({
    super.key,
    required this.billDetails,
  });

  @override
  State<ConfirmBillScreen> createState() => _ConfirmBillScreenState();
}

class _ConfirmBillScreenState extends State<ConfirmBillScreen> {
  late List<TextEditingController> controllers;

  @override
  void initState() {
    controllers = List.generate(
      widget.billDetails.members.length,
      (index) {
        return TextEditingController(
          text: (widget.billDetails.amount / widget.billDetails.members.length)
              .toStringAsFixed(2),

          // 29.22
        );
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    for (var condtroller in controllers) {
      condtroller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Logger.log(widget.billDetails.toString());
    final localization = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localization.billSummary),
        actions: [
          IconButton.filled(
            onPressed: () {
              context.goNamed('dashboard');
            },
            icon: const Icon(CupertinoIcons.multiply),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipPath(
          clipper: SineWaveClipper(),
          child: Container(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 50),
            constraints: const BoxConstraints(
              minWidth: double.infinity,
              minHeight: 500,
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 4,
              children: [
                Text(
                  widget.billDetails.billName,
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                Text(
                  DateFormat("MMM d, yyyy . hh:mm a").format(DateTime.now()),
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontSize: 14,
                  ),
                ),
                const Divider(),
                Expanded(
                  child: NotificationListener(
                    onNotification:
                        (OverscrollIndicatorNotification notification) {
                      notification.disallowIndicator();
                      return true;
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        spacing: 4,
                        children: List.generate(
                          widget.billDetails.members.length,
                          (index) {
                            return ListTile(
                              title: Text(widget.billDetails.members[index]),
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey.withAlpha(30),
                              ),
                              trailing: IntrinsicWidth(
                                child: TextField(
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.number,
                                  controller: controllers[index],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      localization.totalbill,
                      style: theme.textTheme.bodyLarge!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      widget.billDetails.amount.toString(),
                      style: theme.textTheme.bodyLarge!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FilledButton(
          style: FilledButton.styleFrom(
            fixedSize: const Size.fromHeight(50),
          ),
          onPressed: () {},
          child: Text(localization.confirm),
        ),
      ),
    );
  }
}

class SineWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // Baseline for the bottom edge (flat part)
    final double baseline = size.height - 20;
    // Amplitude of the sine waves
    const double waveHeight = 5;
    // How many complete waves you want across the bottom
    const int waveCount = 15;
    // The number of segments to approximate the sine wave smoothly.
    const int segments = 100;

    Path path = Path();

    // Top edge: move from left to right
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);

    // Right vertical edge down to the baseline
    path.lineTo(size.width, size.height);

    // Draw the bottom sine waves from right to left
    for (int i = 0; i <= segments; i++) {
      double fraction = i / segments;
      double x = (size.width - fraction * size.width) + 8;
      double angle = fraction * 2 * pi * waveCount;
      double y = (baseline + waveHeight * sin(angle)) - 8;
      path.lineTo(x, y);
    }

    // Left vertical edge to complete the shape
    path.lineTo(0, baseline);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(SineWaveClipper oldClipper) => false;
}

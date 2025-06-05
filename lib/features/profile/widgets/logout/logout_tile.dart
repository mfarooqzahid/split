import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:split/core/utils/flutter_toast.dart';
import 'package:split/core/utils/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LogoutTile extends StatefulWidget {
  const LogoutTile({super.key});

  @override
  State<LogoutTile> createState() => _LogoutTileState();
}

class _LogoutTileState extends State<LogoutTile> {
  Future<void> _logout() async {
    try {
      await Supabase.instance.client.auth.signOut();
      if (mounted) {
        context.goNamed('login');
      }
    } on AuthException catch (e) {
      Logger.log("log out error : ${e.message}");
      showErrorToast(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return ListTile(
      // logging out
      onTap: _logout,
      minVerticalPadding: 0,
      title: Text(localization.logOut),
      trailing: const Icon(
        CupertinoIcons.power,
      ),
    );
  }
}
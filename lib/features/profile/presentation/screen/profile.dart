import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:split/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:split/features/profile/presentation/widgets/language/language_tile.dart';
import 'package:split/features/profile/presentation/widgets/logout/logout_tile.dart';
import 'package:split/features/profile/presentation/widgets/theme/theme_tile.dart';
import '/l10n/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    final userId = GetIt.I<SupabaseClient>().auth.currentUser!.id;
    context.read<ProfileBloc>().add(FetchProfile(userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: NotificationListener(
          onNotification: (OverscrollIndicatorNotification notification) {
            notification.disallowIndicator();
            return true;
          },
          child: SingleChildScrollView(
            child: Column(
              spacing: 4,
              children: [
                SizedBox(height: 10),
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    return ClipOval(
                      child: ColoredBox(
                        color: Colors.grey.withAlpha(30),
                        child: SizedBox.square(
                          dimension: 100,
                          child: state is ProfileSuccess
                              ? SvgPicture.network(
                                  state.profile.profileUrl,
                                )
                              : null,
                        ),
                      ),
                    );
                  },
                ),
                Column(
                  children: [
                    const Divider(),
                    BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                        final userName =
                            state is ProfileSuccess ? state.profile.name : "";
                        return ListTile(
                          minVerticalPadding: 0,
                          onTap: () {
                            context.goNamed('edit-profile');
                          },
                          title: Text(userName),
                          trailing: const Icon(CupertinoIcons.pencil),
                        );
                      },
                    ),
                    const Divider(),
                    BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                        final email =
                            state is ProfileSuccess ? state.profile.email : "";
                        return ListTile(
                          minVerticalPadding: 0,
                          title: Text(email),
                          trailing: const Icon(CupertinoIcons.mail),
                        );
                      },
                    ),
                    const Divider(),
                    const ThemeTile(),
                    const Divider(),
                    const LanguageTile(),
                    const Divider(),
                    const LogoutTile(),
                    const Divider(),
                    ListTile(
                      minVerticalPadding: 0,
                      title: Text(localization.deleteAccount),
                      trailing: Icon(
                        CupertinoIcons.delete,
                        color: theme.colorScheme.error,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

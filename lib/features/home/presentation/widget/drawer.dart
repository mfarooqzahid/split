import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:split/core/widgets/bottom_sheet_widget.dart';
import 'package:split/features/groups/presentation/widgets/create_group.dart';
import '/l10n/app_localizations.dart';
import 'package:split/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  void initState() {
    final userId = GetIt.I<SupabaseClient>().auth.currentUser!.id;
    context.read<ProfileBloc>().add(FetchProfile(userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  context.pop();

                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    showDragHandle: false,
                    enableDrag: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.vertical(
                        top: Radius.circular(12),
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    context: context,
                    builder: (context) => BottomSheetWidget(
                      title: "Create Group",
                      child: CreateGroupBottomSheet(),
                    ),
                  );
                },
                title: Text(localization.createGroup),
                leading: const Icon(CupertinoIcons.plus),
              ),
              ListTile(
                onTap: () {
                  // TODO: handle join group functionality
                },
                title: Text(localization.joinGroup),
                leading: const Icon(CupertinoIcons.person_2),
              ),

              // TODO: Display the user's groups
              const Spacer(),
              // GO to [ProfileScreen]
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  return ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      context.goNamed('profile');
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey.withAlpha(30),
                      child: state is ProfileSuccess
                          ? SvgPicture.network(state.profile.profileUrl)
                          : null,
                    ),
                    title: Text(
                      state is ProfileSuccess ? state.profile.name : "",
                      style: theme.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    trailing: const Icon(CupertinoIcons.forward),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

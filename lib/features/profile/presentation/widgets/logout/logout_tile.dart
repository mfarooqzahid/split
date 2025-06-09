import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:split/core/utils/flutter_toast.dart';
import 'package:split/core/utils/loading_indicator.dart';
import 'package:split/features/profile/data/repository/profile_repository.dart';
import 'package:split/features/profile/presentation/widgets/logout/logout_cubit.dart';

class LogoutTile extends StatefulWidget {
  const LogoutTile({super.key});

  @override
  State<LogoutTile> createState() => _LogoutTileState();
}

class _LogoutTileState extends State<LogoutTile> {

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (_) => LogoutCubit(
        profileRepository: GetIt.I<ProfileRepositoryImpl>(),
      ),
      child: BlocConsumer<LogoutCubit, LogoutState>(
        listener: (context, state) {

          if(state is LogoutSuccess) {
            context.goNamed('login');
          }
          if(state is LogoutError) {
              showErrorToast(state.message);
          }

        },
        builder: (context, state) {
          return ListTile(
            // logging out
            onTap: () {
              context.read<LogoutCubit>().logout();
            },
            minVerticalPadding: 0,
            title: Text(localization.logOut),
            trailing: state is LogoutLoading
                ? const LoadingIndicator(size: 20)
                : const Icon(CupertinoIcons.power),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:go_transitions/go_transitions.dart';
import 'package:split/core/utils/error_screen.dart';
import 'package:split/core/utils/loading_indicator.dart';
import 'package:split/core/utils/logger.dart';
import 'package:split/features/auth/screen/signin.dart';
import 'package:split/features/home/presentation/screen/home.dart';
import 'package:split/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:split/features/profile/presentation/screen/complete_profile.dart';
import 'package:split/features/profile/presentation/screen/profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '/features/bill_details/models/bill_details_model.dart';
import '/features/bill_details/screen/bill_details.dart';
import '/features/bill_details/screen/confirm_bill.dart';
import '../features/home/presentation/widget/amountkeypad.dart';

final GoRouter goRouter = GoRouter(
  initialLocation: "/home",
  redirect: (context, state) {
    final user = GetIt.I<SupabaseClient>().auth.currentUser;

    // if user is not null then go to splash screen and get
    return user != null ? null : "/login";
  },
  routes: [
    GoRoute(
      path: "/login",
      name: "login",
      builder: (_, __) => const SigninScreen(),
      pageBuilder: GoTransitions.fade.call,
    ),
    GoRoute(
      path: '/compelete-profile',
      name: 'complete-profile',
      builder: (_, state) => CompleteProfileScreen(
        user: GetIt.I<SupabaseClient>().auth.currentUser!,
      ),
    ),
    GoRoute(
      path: "/home",
      name: "home",
      builder: (_, __) => BlocConsumer<ProfileBloc, ProfileState>(
        bloc: GetIt.I<ProfileBloc>()
          ..add(FetchProfile(GetIt.I<SupabaseClient>().auth.currentUser!.id)),
        listener: (context, state) {
          Logger.log(state.toString());
          if (state is ProfileIncomplete) {
            Logger.log(
                "[Profile State Incomplete]: going to profile complete route");
            context.goNamed('complete-profile');
          }
          if (state is ProfileSuccess) {
            Logger.log("Profile fetched successfully");
          }
        },
        builder: (context, state) => state is ProfileSuccess
            ? const HomeScreen()
            : state is ProfileFailure
                ? const ErrorScreen()
                : const Scaffold(
                    body: Center(
                      child: LoadingIndicator(),
                    ),
                  ),
      ),
      pageBuilder: GoTransitions.fade.call,
      routes: [
        GoRoute(
            path: "/profile",
            name: "profile",
            builder: (context, state) => const ProfileScreen(),
            pageBuilder: GoTransitions.cupertino.call,
            routes: [
              GoRoute(
                path: '/edit-profile',
                name: 'edit-profile',
                builder: (_, state) => CompleteProfileScreen(
                  user: GetIt.I<SupabaseClient>().auth.currentUser!,
                  isEditing: true,
                ),
              ),
            ]),
        GoRoute(
          path: "/amountkeypad",
          name: "amountkeypad",
          builder: (_, __) => const Amountkeypad(),
          pageBuilder: GoTransitions.cupertino.call,
          routes: [
            GoRoute(
                path: "/billdetails",
                name: "billdetails",
                builder: (_, state) => BillDetailsScreen(
                      amount: double.parse(state.extra as String),
                    ),
                pageBuilder: GoTransitions.cupertino.call,
                routes: [
                  GoRoute(
                    path: "/confirmbill",
                    name: "confirmbill",
                    builder: (_, state) => ConfirmBillScreen(
                      billDetails: state.extra as BillDetailsModel,
                    ),
                    pageBuilder: GoTransitions.cupertino.call,
                  ),
                ]),
          ],
        ),
      ],
    ),
  ],
);

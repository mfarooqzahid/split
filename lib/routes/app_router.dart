import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:go_transitions/go_transitions.dart';
import 'package:split/features/auth/screen/signin.dart';
import 'package:split/features/home/screen/home.dart';
import 'package:split/features/profile/bloc/profile_bloc.dart';
import 'package:split/features/profile/screen/complete_profile.dart';
import 'package:split/features/profile/screen/profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '/features/bill_details/models/bill_details_model.dart';
import '/features/bill_details/screen/bill_details.dart';
import '/features/bill_details/screen/confirm_bill.dart';
import '/features/home/widget/amountkeypad.dart';

final GoRouter goRouter = GoRouter(
  initialLocation: "/home",
  redirect: (context, state) {
    final user = Supabase.instance.client.auth.currentUser;

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
      builder: (_, state) => const CompleteProfileScreen(),
    ),
    GoRoute(
      path: "/home",
      name: "home",
      builder: (_, __) => BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileIncomplete) {
            context.goNamed('complete-profile');
          }
        },
        child: const HomeScreen(),
      ),
      pageBuilder: GoTransitions.fade.call,
      routes: [
        GoRoute(
          path: "/profile",
          name: "profile",
          builder: (context, state) => const ProfileScreen(),
          pageBuilder: GoTransitions.cupertino.call,
        ),
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

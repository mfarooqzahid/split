import 'package:go_router/go_router.dart';
import 'package:go_transitions/go_transitions.dart';
import 'package:split/features/auth/screen/signin.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '/features/bill_details/models/bill_details_model.dart';
import '/features/bill_details/screen/bill_details.dart';
import '/features/bill_details/screen/confirm_bill.dart';
import '/features/dashboard.dart';
import '/features/home/widget/amountkeypad.dart';

final GoRouter goRouter = GoRouter(
  initialLocation: "/dashboard",
  redirect: (context, state) {
    final user = Supabase.instance.client.auth.currentUser;
    return user != null ? null : "/login";
  },
  routes: [
    GoRoute(
      path: "/login",
      name: "login",
      builder: (_, __) => const SigninScreen(),
      pageBuilder: GoTransitions.fade.call,
    ),
    // GoRoute(
    //   path: "/signup",
    //   name: "signup",
    //   builder: (_, __) => const SignupBottomSheet(),
    //   pageBuilder: GoTransitions.fade.call,
    // ),
    // GoRoute(
    //   path: "/verifyotp",
    //   name: "verifyotp",
    //   builder: (_, __) => const VerifyOtp(),
    //   pageBuilder: GoTransitions.fade.call,
    // ),
    GoRoute(
      path: "/dashboard",
      name: "dashboard",
      builder: (_, __) => const DashboardScreen(),
      pageBuilder: GoTransitions.fade.call,
      routes: [
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

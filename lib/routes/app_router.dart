import 'package:go_router/go_router.dart';
import 'package:go_transitions/go_transitions.dart';
import '/features/bill_details/data/models/bill_details_model.dart';
import '/features/bill_details/presentation/screen/bill_details.dart';
import '/features/bill_details/presentation/screen/confirm_bill.dart';
import '/features/dashboard.dart';
import '/features/home/presentation/widget/amountkeypad.dart';

final GoRouter goRouter = GoRouter(
  initialLocation: "/dashboard",
  routes: [
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

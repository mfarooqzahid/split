import 'package:go_router/go_router.dart';
import 'package:go_transitions/go_transitions.dart';
import 'package:split/features/dashboard.dart';
import 'package:split/features/home/presentation/widget/amountkeypad.dart';

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
          pageBuilder: GoTransitions.slide.toLeft.call,
        ),
      ],
    ),
  ],
);

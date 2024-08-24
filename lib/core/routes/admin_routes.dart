

import 'package:bsmart_first_app/features/home/presentation/pages/main_page.dart';
import 'package:go_router/go_router.dart';

class AdminRoutes {
  static const String initial = "/admin/main-page";

  static List<RouteBase> routes = [
    GoRoute(
      path: initial,
      builder: (context, state) => const MainPage(),
    ),
  ];
}

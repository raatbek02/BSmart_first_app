import 'package:bsmart_first_app/features/arrival/presentation/pages/arrival_page.dart';
import 'package:bsmart_first_app/features/expense/presentation/pages/expense_page.dart';
import 'package:bsmart_first_app/features/home/presentation/pages/main_page.dart';
import 'package:go_router/go_router.dart';

class AdminRoutes {
  static const String initial = "/admin/main-page";
  static const String arrivalRoute = "/admin/arrival-page";
  static const String expenseRoute = "/admin/expense-page";

  static List<RouteBase> routes = [
    GoRoute(
      path: initial,
      builder: (context, state) => const MainPage(),
    ),
    GoRoute(
      path: arrivalRoute,
      builder: (context, state) => const ArrivalPage(),
    ),
    GoRoute(
      path: expenseRoute,
      builder: (context, state) => const ExpensePage(),
    ),
  ];
}

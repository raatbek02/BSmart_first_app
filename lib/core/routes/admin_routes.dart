import 'package:bsmart_first_app/features/arrival/presentation/pages/arrival_filter_page.dart';
import 'package:bsmart_first_app/features/arrival/presentation/pages/arrival_page.dart';
import 'package:bsmart_first_app/features/arrival/presentation/pages/create_arrival_page.dart';
import 'package:bsmart_first_app/features/arrival/presentation/pages/arrival_detail_page.dart';
import 'package:bsmart_first_app/features/arrival/presentation/pages/products_page.dart';
import 'package:bsmart_first_app/features/expense/presentation/pages/expense_page.dart';
import 'package:bsmart_first_app/features/home/presentation/pages/main_page.dart';
import 'package:go_router/go_router.dart';

class AdminRoutes {
  static const String initial = "/admin/main-page";
  // Arrival Page
  static const String arrivalRoute = "/admin/arrival-page";
  static const String arrivalFilterPage = "/admin/arrival-filter-page";
  static const String createArrivalPage = "/admin/create-arrival-page";
  static const String productsPage = "/admin/products-page";
  static const String arrivalDetailPage = "/admin/arrival-detail-page";
  // Expense Page
  static const String expenseRoute = "/admin/expense-page";
  static const String expenseFilterPage = "/admin/expense-filter-page";

  static List<RouteBase> routes = [
    GoRoute(
      path: initial,
      builder: (context, state) => const MainPage(),
    ),
    // Arrival Page
    GoRoute(
      path: arrivalRoute,
      builder: (context, state) => const ArrivalPage(),
    ),
  GoRoute(
      path: '$arrivalDetailPage/:organizationId/:id',
      builder: (context, state) {
        final organizationId = state.pathParameters['organizationId']!;
        final id = state.pathParameters['id']!;
        return ArrivalDetailPage(
          organizationId: organizationId,
          id: id,
        );
      },
    ),

    GoRoute(
      path: arrivalFilterPage,
      builder: (context, state) => const ArrivalFilterPage(),
    ),
    GoRoute(
      path: createArrivalPage,
      builder: (context, state) => const CreateArrivalPage(),
    ),
    GoRoute(
      path: productsPage,
      builder: (context, state) => const ProductsPage(),
    ),

    // Expense Page
    GoRoute(
      path: expenseRoute,
      builder: (context, state) => const ExpensePage(),
    ),
  ];
}

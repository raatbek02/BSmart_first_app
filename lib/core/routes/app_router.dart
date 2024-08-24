import 'package:bsmart_first_app/core/common/pages/error_page.dart';
import 'package:bsmart_first_app/core/helpers/my_logger.dart';
import 'package:bsmart_first_app/core/routes/admin_routes.dart';
import 'package:bsmart_first_app/core/routes/auth_routes.dart';
import 'package:bsmart_first_app/features/splash/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// class AppRouter {
//   static GoRouter getRouter(String userRole) {
//     final routes = <RouteBase>[
//       GoRoute(
//         path: '/splash-page',
//         builder: (context, state) => const SplashScreen(),
//       ),

//       ...AuthRoutes.routes,
//       if (userRole == 'ADMIN') ...AdminRoutes.routes,
//       // if (userRole == 'DOCTOR') ...DoctorRoutes.routes,
//     ];

//     return GoRouter(
//       initialLocation: '/splash-page',
//       routes: routes,
//       errorPageBuilder: (context, state) {
//         return const MaterialPage(
//           child: ErrorPage(),
//         );
//       },
//       redirect: (context, state) {
//         logger.i('redirect: ${state.uri}');
//         return null;
//       },
//     );
//   }
// }

class AppRouter {
  static String userRole = "ADMIN";
  static final routes = <RouteBase>[
    GoRoute(
      path: '/splash-page',
      builder: (context, state) => const SplashScreen(),
    ),

    ...AuthRoutes.routes,
    if (userRole == 'ADMIN') ...AdminRoutes.routes,
    // if (userRole == 'DOCTOR') ...DoctorRoutes.routes,
  ];
}

GoRouter routerInit = GoRouter(
  initialLocation: '/splash-page',
  routes: AppRouter.routes,
  errorPageBuilder: (context, state) {
    return const MaterialPage(
      child: ErrorPage(),
    );
  },
  redirect: (context, state) {
    logger.i('redirect: ${state.uri}');
    return null;
  },
);

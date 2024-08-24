
import 'package:bsmart_first_app/features/auth/presentation/pages/on_boarding_screen.dart';
import 'package:bsmart_first_app/features/auth/presentation/pages/sign_in_page.dart';
import 'package:bsmart_first_app/features/splash/presentation/pages/splash_screen.dart';
import 'package:go_router/go_router.dart';

class AuthRoutes {
  // static const String splashPage = "/splash-page";
  static const String onBoardingPage = "/on-boarding-page";
  static const String signInPage = "/sign-in-page";

  static List<RouteBase> routes = [
    GoRoute(path: onBoardingPage, builder: (context, state) => const OnBoardingPage()),

    GoRoute(
      path: signInPage,
      builder: (context, state) => const SignInPage(),
    ),
  ];
}

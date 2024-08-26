import 'package:bsmart_first_app/core/helpers/my_logger.dart';
import 'package:bsmart_first_app/core/routes/admin_routes.dart';
import 'package:bsmart_first_app/core/routes/auth_routes.dart';
import 'package:bsmart_first_app/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeAndNavigate();
  }

  Future<void> _initializeAndNavigate() async {
    final startTime = DateTime.now();

    try {
      // Получаем статус авторизации
      final authBloc = BlocProvider.of<AuthBloc>(context);
      final isLoggedIn = authBloc.userLoggedIn();

      // Вычисляем прошедшее время
      final elapsedTime = DateTime.now().difference(startTime);
      final remainingTime = const Duration(seconds: 2) - elapsedTime;

      // Если нужно, ждем оставшееся время
      if (remainingTime.isNegative == false) {
        await Future.delayed(remainingTime);
      }

      // Используем mounted для проверки, существует ли еще виджет
      if (!mounted) return;

      // Навигация на основе статуса авторизации
      _navigateBasedOnAuthStatus(isLoggedIn);
    } catch (e) {
      // Обработка ошибок
      logger.e('Error during initialization: $e');
      if (mounted) {
        _navigateToErrorScreen();
      }
    }
  }

  void _navigateBasedOnAuthStatus(bool isLoggedIn) {
    if (isLoggedIn) {
      context.go(AdminRoutes.initial);
    } else {
      context.go(AuthRoutes.onBoardingPage);
    }
  }

  void _navigateToErrorScreen() {
    // Навигация на экран ошибки, если что-то пошло не так
    context.go('/error');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(237, 247, 237, 1),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Center(
              child: SvgPicture.asset(
                'assets/svg/logo.svg',
                width: 200.w,
              ),
            ),
            const Spacer(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}







// Future<void> _initializeAndNavigate() async {
//   final startTime = DateTime.now();

//   try {
//     const userRole = "ADMIN";

//     // Вычисляем прошедшее время
//     final elapsedTime = DateTime.now().difference(startTime);
//     final remainingTime = const Duration(seconds: 2) - elapsedTime;

//     // Если нужно, ждем оставшееся время
//     if (remainingTime.isNegative == false) {
//       await Future.delayed(remainingTime);
//     }
//     // Используем mounted для проверки, существует ли еще виджет
//     if (!mounted) return;
//     // Навигация на основе роли пользователя
//     _navigateBasedOnRole(userRole);
//   } catch (e) {
//     // Обработка ошибок
//     logger.e('Error during initialization: $e');
//     if (mounted) {
//       _navigateToErrorScreen();
//     }
//   }
// }

// void _navigateBasedOnRole(String userRole) {
//   switch (userRole) {
//     case 'ADMIN':
//       context.go(AdminRoutes.initial);
//       break;
//     // case 'DOCTOR':
//     //   context.go(
//     //       DoctorRoutes.initial); // Предполагая, что у вас есть DoctorRoutes
//     //   break;
//     default:
//       context.go(AuthRoutes.onBoardingPage);
//   }
// }

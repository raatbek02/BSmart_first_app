import 'package:bsmart_first_app/core/routes/admin_routes.dart';
import 'package:bsmart_first_app/core/routes/auth_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

    // Используем try-catch для обработки возможных ошибок
    try {
      // Предполагаем, что у вас есть сервис аутентификации
      // final authService = AuthService();
      // final userRole = await authService.getUserRole();
            final userRole = "ADMIN";


      // Вычисляем прошедшее время
      final elapsedTime = DateTime.now().difference(startTime);
      final remainingTime = Duration(seconds: 2) - elapsedTime;

      // Если нужно, ждем оставшееся время
      if (remainingTime.isNegative == false) {
        await Future.delayed(remainingTime);
      }

      // Используем mounted для проверки, существует ли еще виджет
      if (!mounted) return;

      // Навигация на основе роли пользователя
      _navigateBasedOnRole(userRole);
    } catch (e) {
      // Обработка ошибок
      print('Error during initialization: $e');
      if (mounted) {
        _navigateToErrorScreen();
      }
    }
  }

  void _navigateBasedOnRole(String userRole) {
    switch (userRole) {
      case 'ADMIN':
        context.go(AdminRoutes.initial);
        break;
      // case 'DOCTOR':
      //   context.go(
      //       DoctorRoutes.initial); // Предполагая, что у вас есть DoctorRoutes
      //   break;
      default:
        context.go(AuthRoutes.onBoardingPage);
    }
  }

  void _navigateToErrorScreen() {
    // Навигация на экран ошибки, если что-то пошло не так
    context.go('/error');
  }
  @override
  Widget build(BuildContext context) {
        // Запускаем инициализацию и навигацию после построения виджета
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _initializeAndNavigate());

    return Scaffold(
      body: Center(
        child: const Text('Splash Screen'),
      ),
    );
  }
}

import 'package:bsmart_first_app/core/routes/auth_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: const Text('On Boarding Page'),
          ),
          ElevatedButton(
            onPressed: () {
              // context.go(context, '/sign-in-page');
              context.go(AuthRoutes.signInPage);
            },
            child: const Text('Sign In'),
          ),
        ],
      ),
    );
  }
}

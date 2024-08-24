import 'package:bsmart_first_app/core/routes/admin_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: const Text('Sign In Page'),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigator.of(context).pushNamed('/main-page');
              context.go(AdminRoutes.initial);
            },
            child: const Text('Main Page'),
          ),
        ],
      ),
    );
  }
}

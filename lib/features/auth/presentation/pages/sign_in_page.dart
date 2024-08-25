import 'package:bsmart_first_app/core/common/widgets/custom_button.dart';
import 'package:bsmart_first_app/core/routes/admin_routes.dart';
import 'package:bsmart_first_app/features/auth/presentation/widgets/auth_textfields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset:
          true, // Позволяет странице избегать пересечений с клавиатурой
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 60.w),
                Text(
                  "Вход",
                  style: GoogleFonts.poppins(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15.w),
                Text(
                  "Войдите, чтобы продолжить",
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  margin: EdgeInsets.only(top: 30.h),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/svg/lock.svg',
                      width: 170.w,
                      height: 130.w,
                    ),
                  ),
                ),
                SizedBox(height: 40.w),
                AuthTextFields(
                  controller: emailController,
                  hintText: 'E-mail',
                  icon: CupertinoIcons.mail,
                ),
                SizedBox(height: 15.w),
                AuthTextFields(
                  controller: passwordController,
                  hintText: 'Пароль',
                  obscureText: true,
                  icon: CupertinoIcons.lock_fill,
                ),
                SizedBox(height: 40.w),
                CustomButton(
                  text: 'Войти',
                  onPressed: () {
                    context.push(AdminRoutes.initial);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

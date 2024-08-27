import 'package:bsmart_first_app/core/common/widgets/custom_button.dart';
import 'package:bsmart_first_app/core/routes/auth_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(237, 247, 237, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30.h),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/svg/logo.svg',
                        width: 105.w,
                        height: 50.h,
                      ),
                    ),
                  ),
                  // Png Image with rounded corners
                  Container(
                    width: 300.w,
                    height: 300.w,
                    margin: EdgeInsets.only(top: 30.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(70.r),
                      color: Colors.white,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(70.r),
                      child: Image.asset(
                        'assets/images/on_boarding_image.png',
                        width: 300.w,
                        height: 300.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 30.h),
                padding: EdgeInsets.only(
                  left: 15.w,
                  right: 15.w,
                  top: 30.h,
                  bottom: 30.w,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.r),
                    topRight: Radius.circular(40.r),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Добро пожаловать в \n мобильное ТСД",
                      style: GoogleFonts.poppins(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "С легкостью управляйте процессом сбора \n данных, инвентаризацией и учётом товаров с \n помощью нашего удобного мобильного \n приложения ТСД.",
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(113, 114, 122, 1),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.h),
                    CustomButton(
                      text: 'Продолжить',
                      onPressed: () {
                        context.push(AuthRoutes.signInPage);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

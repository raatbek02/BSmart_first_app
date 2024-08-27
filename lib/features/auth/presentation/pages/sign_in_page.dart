import 'package:bsmart_first_app/core/common/widgets/custom_button.dart';
import 'package:bsmart_first_app/core/helpers/my_logger.dart';
import 'package:bsmart_first_app/core/routes/admin_routes.dart';
import 'package:bsmart_first_app/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:bsmart_first_app/features/auth/presentation/widgets/auth_textfields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rxdart/rxdart.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _clickableSubject = PublishSubject<void>();

  @override
  void initState() {
    super.initState();
    _clickableSubject.stream
        .debounceTime(const Duration(milliseconds: 200))
        .listen((_) => _signIn());
  }

  void _signIn() {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    if (email.isEmpty) {
      _showWarningSnackbar(
        title: "E-mail",
        message: 'Введите свой e-mail!',
      );
    } else if (password.isEmpty) {
      _showWarningSnackbar(
        title: "Пароль",
        message: 'Введите свой пароль!',
      );
    } else if (password.length < 4) {
      _showWarningSnackbar(
        title: "Пароль",
        message: 'Пароль не может быть короче 4 символов!',
      );
    } else {
      context.read<AuthBloc>().add(SignInEvent(email, password));
    }
  }

  void _showWarningSnackbar({required String title, required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title: $message'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  void _handleAuthFailure(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  void dispose() {
    _clickableSubject.close();
    emailController.dispose();
    passwordController.dispose();
    // focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 247, 250, 1),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSignInSuccess) {
              // if (state.role == 'USER') {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Вы успешно вошли в свой аккаунт!'),
                  backgroundColor: Colors.green,
                ),
              );
              context.go(AdminRoutes.initial);
             
            } else if (state is AuthFailure) {
              logger.e("Auth failure state received: ${state.error}");
              _handleAuthFailure(context, state.error);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              logger.i("AuthLoading state received");
              return Center(
                child: SpinKitFadingCircle(
                  color: Colors.black,
                  size: 50.sp,
                ),
              );
            }
            return SingleChildScrollView(
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
                        // context.push(AdminRoutes.initial);
                        _clickableSubject.add(null);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}



// class SignInPage extends StatefulWidget {
//   const SignInPage({super.key});

//   @override
//   State<SignInPage> createState() => SignInPageState();
// }

// class SignInPageState extends State<SignInPage> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final Dio _dio = Dio();

//   Future<void> signIn() async {
//     try {
//       final response = await _dio.post(
//         'https://demo.bsmart.kg/api/users/auth',
//         data: {
//           'email': emailController.text,
//           'password': passwordController.text,
//         },
//         options: Options(
//           headers: {'Content-Type': 'application/json'},
//         ),
//       );

//       if (response.statusCode == 200) {
//         // Успешный вход
//         print('Вход выполнен успешно: ${response.data}');
//         // Здесь вы можете обработать ответ, например, сохранить токен
//         // и перейти на следующий экран
//         // context.push(AdminRoutes.initial);
//       } else {
//         // Ошибка входа
//         print('Ошибка входа: ${response.data}');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//               content: Text(
//                   'Ошибка входа. Пожалуйста, проверьте введенные данные.')),
//         );
//       }
//     } on DioException catch (e) {
//       // Обработка ошибок Dio
//       print('Ошибка Dio: ${e.message}');
//       String errorMessage = 'Произошла ошибка. Пожалуйста, попробуйте позже.';
//       if (e.response != null) {
//         // Сервер вернул ответ с кодом ошибки
//         errorMessage =
//             'Ошибка: ${e.response?.statusCode}. ${e.response?.data['message'] ?? ''}';
//       } else if (e.type == DioExceptionType.connectionTimeout) {
//         errorMessage = 'Превышено время ожидания соединения.';
//       } else if (e.type == DioExceptionType.receiveTimeout) {
//         errorMessage = 'Превышено время ожидания ответа.';
//       } else if (e.type == DioExceptionType.sendTimeout) {
//         errorMessage = 'Превышено время отправки запроса.';
//       }
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(errorMessage)),
//       );
//     } catch (e) {
//       print('Непредвиденная ошибка: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//             content: Text(
//                 'Произошла непредвиденная ошибка. Пожалуйста, попробуйте позже.')),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     // focusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       resizeToAvoidBottomInset: true,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.w),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(height: 60.w),
//                 Text(
//                   "Вход",
//                   style: GoogleFonts.poppins(
//                     fontSize: 22.sp,
//                     fontWeight: FontWeight.w600,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: 15.w),
//                 Text(
//                   "Войдите, чтобы продолжить",
//                   style: GoogleFonts.poppins(
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w600,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(top: 30.h),
//                   child: Center(
//                     child: SvgPicture.asset(
//                       'assets/svg/lock.svg',
//                       width: 170.w,
//                       height: 130.w,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 40.w),
//                 AuthTextFields(
//                   controller: emailController,
//                   hintText: 'E-mail',
//                   icon: CupertinoIcons.mail,
//                 ),
//                 SizedBox(height: 15.w),
//                 AuthTextFields(
//                   controller: passwordController,
//                   hintText: 'Пароль',
//                   obscureText: true,
//                   icon: CupertinoIcons.lock_fill,
//                 ),
//                 SizedBox(height: 40.w),
//                 CustomButton(
//                   text: 'Войти',
//                   onPressed: () {
//                     // context.push(AdminRoutes.initial);
//                     signIn();
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

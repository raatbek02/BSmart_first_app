// import 'package:bsmart_first_app/core/common/widgets/custom_button.dart';
// import 'package:bsmart_first_app/core/helpers/my_logger.dart';
// import 'package:bsmart_first_app/core/routes/admin_routes.dart';
// import 'package:bsmart_first_app/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
// import 'package:bsmart_first_app/features/auth/presentation/widgets/auth_textfields.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:go_router/go_router.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:rxdart/subjects.dart';

// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class SignInPage extends StatefulWidget {
//   const SignInPage({super.key});

//   @override
//   State<SignInPage> createState() => SignInPageState();
// }

// class SignInPageState extends State<SignInPage> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//     final Dio _dio = Dio();

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

// Future<void> signIn() async {
//   final url = Uri.parse('https://demo.bsmart.kg/api/users/auth');

//   try {
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode({
//         'email': emailController.text,
//         'password': passwordController.text,
//       }),
//     );

//     if (response.statusCode == 200) {
//       // Успешный вход
//       final responseData = json.decode(response.body);
//       // Здесь вы можете обработать ответ, например, сохранить токен
//       print('Вход выполнен успешно: $responseData');
//       // Переход на следующий экран
//       // context.push(AdminRoutes.initial);
//     } else {
//       // Ошибка входа
//       print('Ошибка входа: ${response.body}');
//       // Показать сообщение об ошибке пользователю
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//             content: Text(
//                 'Ошибка входа. Пожалуйста, проверьте введенные данные.')),
//       );
//     }
//   } catch (e) {
//     print('Ошибка при выполнении запроса: $e');
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//           content: Text('Произошла ошибка. Пожалуйста, попробуйте позже.')),
//     );
//   }
// }

import 'package:bsmart_first_app/core/utils/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  final SharedPreferences sharedPreferences;
  final String appBaseUrl;
  late Dio _dio;

  ApiClient({
    required this.appBaseUrl,
    required this.sharedPreferences,
  }) {
    _dio = Dio(BaseOptions(
      baseUrl: appBaseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));
    _dio.interceptors.add(_AuthInterceptor(sharedPreferences));
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  Future<Response<T>> postData<T>(String uri, dynamic data) async {
    try {
      final response = await _dio.post<T>(uri, data: data);
      return response;
    } catch (e) {
      return _handleError<T>(e);
    }
  }

  Response<T> _handleError<T>(dynamic error) {
    if (error is DioException) {
      String errorMessage;
      Map<String, dynamic>? errorData;

      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          errorMessage = 'Connection timeout';
          break;
        case DioExceptionType.sendTimeout:
          errorMessage = 'Send timeout';
          break;
        case DioExceptionType.receiveTimeout:
          errorMessage = 'Receive timeout';
          break;
        case DioExceptionType.badResponse:
          if (error.response?.data != null) {
            if (error.response!.data is Map<String, dynamic>) {
              errorData = error.response!.data as Map<String, dynamic>;
              errorMessage = errorData['message'] ??
                  'Bad response: ${error.response?.statusCode}';
            } else if (error.response!.data is String) {
              errorMessage = error.response!.data;
            } else {
              errorMessage = 'Bad response: ${error.response?.statusCode}';
            }
          } else {
            errorMessage = 'Bad response: ${error.response?.statusCode}';
          }
          break;
        case DioExceptionType.cancel:
          errorMessage = 'Request cancelled';
          break;
        default:
          errorMessage = 'Network error occurred';
      }

      return Response<T>(
        requestOptions: error.requestOptions,
        statusCode: error.response?.statusCode ?? 500,
        statusMessage: errorMessage,
        data: errorData as T?,
      );
    }
    return Response<T>(
      requestOptions: RequestOptions(path: ''),
      statusCode: 500,
      statusMessage: 'Unexpected error occurred',
    );
  }
}

class _AuthInterceptor extends Interceptor {
  final SharedPreferences sharedPreferences;

  _AuthInterceptor(this.sharedPreferences);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = sharedPreferences.getString(AppConstants.TOKEN) ?? "";
    options.headers['Authorization'] = 'Bearer $token';
    // options.headers['Content-Type'] = 'application/json; charset=UTF-8';
    options.headers['Content-Type'] = 'application/json';

    super.onRequest(options, handler);
  }
}

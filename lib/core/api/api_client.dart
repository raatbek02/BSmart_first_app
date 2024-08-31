import 'package:bsmart_first_app/core/api/api_constants.dart';
import 'package:bsmart_first_app/core/helpers/my_logger.dart';
import 'package:bsmart_first_app/core/utils/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';



// Более подробный и правильный вариант

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
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
      logPrint: (object) => logger.d(object),
    ));
  }

  Future<Response<T>> getData<T>(String uri,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get<T>(uri, queryParameters: queryParameters);
      return response;
    } catch (e) {
      return _handleError<T>(e);
    }
  }

  Future<Response<T>> postData<T>(String uri, dynamic data) async {
    logger.i("Sending POST request to $uri");
    logger.i("Request data: $data");

    try {
      final response = await _dio.post<T>(uri, data: data);
      logger.i("Response received: ${response.statusCode}");
      logger.i("Response data: ${response.data}");
      return response;
    } catch (e) {
      logger.e("Error in postData: $e");
      return _handleError<T>(e);
    }
  }

  Future<Response<T>> putData<T>(String uri, dynamic data) async {
    try {
      final response = await _dio.put<T>(uri, data: data);
      return response;
    } catch (e) {
      return _handleError<T>(e);
    }
  }

  Future<Response<T>> deleteData<T>(String uri) async {
    try {
      final response = await _dio.delete<T>(uri);
      return response;
    } catch (e) {
      return _handleError<T>(e);
    }
  }

  Future<Response<T>> uploadFile<T>(String uri, String filePath) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
      });
      final response = await _dio.post<T>(uri, data: formData);
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

      logger.e("DioException: $errorMessage");
      logger.e("Error response data: ${error.response?.data}");
      logger.e("Error response headers: ${error.response?.headers}");

      return Response<T>(
        requestOptions: error.requestOptions,
        statusCode: error.response?.statusCode ?? 500,
        statusMessage: errorMessage,
        data: errorData as T?,
      );
    }
    logger.e("Unexpected error: $error");
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
    final token = sharedPreferences.getString(ApiConstants.TOKEN);
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
      logger.i("Added Authorization header: Bearer $token");
    } else {
      logger.w("No token found in SharedPreferences");
    }
    options.headers['Content-Type'] = 'application/json; charset=UTF-8';
    logger.i("Request headers: ${options.headers}");
    logger.i("Request method: ${options.method}");
    logger.i("Request path: ${options.path}");
    logger.i("Request data: ${options.data}");

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.i("Response received: ${response.statusCode}");
    logger.i("Response data: ${response.data}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e("Error in request: ${err.message}");
    logger.e("Error type: ${err.type}");
    logger.e("Error response: ${err.response}");
    super.onError(err, handler);
  }
}








// class ApiClient {
//   final SharedPreferences sharedPreferences;
//   final String appBaseUrl;
//   late Dio _dio;

//   ApiClient({
//     required this.appBaseUrl,
//     required this.sharedPreferences,
//   }) {
//     _dio = Dio(BaseOptions(
//       baseUrl: appBaseUrl,
//       connectTimeout: const Duration(seconds: 30),
//       receiveTimeout: const Duration(seconds: 30),
//     ));
//     _dio.interceptors.add(_AuthInterceptor(sharedPreferences));
//     _dio.interceptors.add(LogInterceptor(responseBody: true));
//   }

//   Future<Response<T>> getData<T>(String uri,
//       {Map<String, dynamic>? queryParameters}) async {
//     try {
//       final response = await _dio.get<T>(uri, queryParameters: queryParameters);
//       return response;
//     } catch (e) {
//       return _handleError<T>(e);
//     }
//   }

//   Future<Response<T>> postData<T>(String uri, dynamic data) async {
//     try {
//       final response = await _dio.post<T>(uri, data: data);
//       return response;
//     } catch (e) {
//       return _handleError<T>(e);
//     }
//   }

//   Future<Response<T>> putData<T>(String uri, dynamic data) async {
//     try {
//       final response = await _dio.put<T>(uri, data: data);
//       return response;
//     } catch (e) {
//       return _handleError<T>(e);
//     }
//   }

//   Future<Response<T>> deleteData<T>(String uri) async {
//     try {
//       final response = await _dio.delete<T>(uri);
//       return response;
//     } catch (e) {
//       return _handleError<T>(e);
//     }
//   }

//   Future<Response<T>> uploadFile<T>(String uri, String filePath) async {
//     try {
//       final formData = FormData.fromMap({
//         'file': await MultipartFile.fromFile(filePath),
//       });
//       final response = await _dio.post<T>(uri, data: formData);
//       return response;
//     } catch (e) {
//       return _handleError<T>(e);
//     }
//   }

//   Response<T> _handleError<T>(dynamic error) {
//     if (error is DioException) {
//       String errorMessage;
//       Map<String, dynamic>? errorData;

//       switch (error.type) {
//         case DioExceptionType.connectionTimeout:
//           errorMessage = 'Connection timeout';
//           break;
//         case DioExceptionType.sendTimeout:
//           errorMessage = 'Send timeout';
//           break;
//         case DioExceptionType.receiveTimeout:
//           errorMessage = 'Receive timeout';
//           break;
//         case DioExceptionType.badResponse:
//           if (error.response?.data != null) {
//             if (error.response!.data is Map<String, dynamic>) {
//               errorData = error.response!.data as Map<String, dynamic>;
//               errorMessage = errorData['message'] ??
//                   'Bad response: ${error.response?.statusCode}';
//             } else if (error.response!.data is String) {
//               errorMessage = error.response!.data;
//             } else {
//               errorMessage = 'Bad response: ${error.response?.statusCode}';
//             }
//           } else {
//             errorMessage = 'Bad response: ${error.response?.statusCode}';
//           }
//           break;
//         case DioExceptionType.cancel:
//           errorMessage = 'Request cancelled';
//           break;
//         default:
//           errorMessage = 'Network error occurred';
//       }

//       return Response<T>(
//         requestOptions: error.requestOptions,
//         statusCode: error.response?.statusCode ?? 500,
//         statusMessage: errorMessage,
//         data: errorData as T?,
//       );
//     }
//     return Response<T>(
//       requestOptions: RequestOptions(path: ''),
//       statusCode: 500,
//       statusMessage: 'Unexpected error occurred',
//     );
//   }
// }

// class _AuthInterceptor extends Interceptor {
//   final SharedPreferences sharedPreferences;

//   _AuthInterceptor(this.sharedPreferences);

//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     final token = sharedPreferences.getString(AppConstants.TOKEN) ?? "";
//     options.headers['Authorization'] = 'Bearer $token';
//     options.headers['Content-Type'] = 'application/json; charset=UTF-8';
//     // options.headers['Content-Type'] = 'application/json';

//     super.onRequest(options, handler);
//   }
// }

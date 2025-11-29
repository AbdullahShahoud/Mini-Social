// lib/core/services/dio_services.dart
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:social_app/core/error/erorr_handler.dart';
import 'package:social_app/features/auth/presentation/cubit/login_cubit/cubit/login_cubit_cubit.dart';
import '../error/errors.dart';
import '../services/injection.dart';
import '../services/secure_storage.dart';

class DioServicies {
  final Dio _dio;
  final ErrorHandlerService errorHandler;

  DioServicies({
    required String baseUrl,
    required this.errorHandler,
    Map<String, String>? defaultHeaders,
    Duration connectTimeout = const Duration(seconds: 30),
    Duration receiveTimeout = const Duration(seconds: 30),
  }) : _dio = Dio() {
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
      headers:
          defaultHeaders ??
          {'Content-Type': 'application/json', 'Accept': 'application/json'},
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('👉 إرسال طلب ${options.method} إلى ${options.uri}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print(
            '✅ استجابة ${response.statusCode} من ${response.requestOptions.uri}',
          );
          return handler.next(response);
        },
        onError: (DioException error, handler) async {
          print(
            '❌ خطأ ${error.response?.statusCode} من ${error.requestOptions.uri}',
          );
          if (error.response?.statusCode == 401) {
            try {
              print('🔄 اكتشاف 401، تجديد الـ token...');

              // استدعاء الـ Cubit مباشرة
              final cubit = getIt<LoginCubitCubit>();
              await cubit.referacheToken();

              // أعد الطلب الأصلي بالـ token الجديد
              final token = await StorageToken.getSecureString('token');
              error.requestOptions.headers['Authorization'] = 'Bearer $token';

              final retryResponse = await _dio.fetch(error.requestOptions);
              handler.resolve(retryResponse);
            } catch (e) {
              print('❌ فشل التجديد: $e');
              handler.next(error);
            }
          } else {
            handler.next(error);
          }
        },
      ),
    );
  }

  Future<Either<Failure, T>> get<T>({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    CancelToken? cancelToken,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );
      return _handleResponse(response, fromJson);
    } on DioException catch (e) {
      final failure = errorHandler.handleDioError(e);
      return Left(failure);
    } catch (e) {
      final failure = errorHandler.handleGenericError(e);
      return Left(failure);
    }
  }

  Future<Either<Failure, T>> post<T>({
    required String endpoint,
    Map<String, dynamic>? body,
    String? rawBody,
    Map<String, String>? headers,
    CancelToken? cancelToken,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: rawBody ?? body,
        options: Options(headers: headers, followRedirects: false),
        cancelToken: cancelToken,
      );
      return _handleResponse(response, fromJson);
    } on DioException catch (e) {
      final failure = errorHandler.handleDioError(e);
      return Left(failure);
    } catch (e) {
      final failure = errorHandler.handleGenericError(e);
      return Left(failure);
    }
  }

  Future<Either<Failure, T>> put<T>({
    required String endpoint,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: body,
        queryParameters: queryParameters,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );
      return _handleResponse(response, fromJson);
    } on DioException catch (e) {
      final failure = errorHandler.handleDioError(e);
      return Left(failure);
    } catch (e) {
      final failure = errorHandler.handleGenericError(e);
      return Left(failure);
    }
  }

  Future<Either<Failure, T>> delete<T>({
    required String endpoint,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        data: body,
        queryParameters: queryParameters,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );
      return _handleResponse(response, fromJson);
    } on DioException catch (e) {
      final failure = errorHandler.handleDioError(e);
      return Left(failure);
    } catch (e) {
      final failure = errorHandler.handleGenericError(e);
      return Left(failure);
    }
  }

  // معالجة الاستجابة الناجحة فقط
  Either<Failure, T> _handleResponse<T>(
    Response response,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    try {
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        if (response.data == null) {
          return Right(null as T);
        }
        final result = fromJson(response.data);
        return Right(result);
      } else {
        return Left(
          ServerFailure(
            'Request failed with status ${response.statusCode}',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (e) {
      final failure = errorHandler.handleGenericError(e);
      return Left(failure);
    }
  }

  void addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }

  void cancelAllRequests({String? reason}) {
    _dio.close(force: true);
  }
}

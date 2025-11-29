// lib/core/error/error_handler.dart
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'errors.dart';

class ErrorHandlerService {
  Failure handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkFailure('انتهت مهلة الاتصال. يرجى المحاولة مرة أخرى');

      case DioExceptionType.badResponse:
        return _handleBadResponse(e);

      case DioExceptionType.cancel:
        return NetworkFailure('تم إلغاء الطلب');

      case DioExceptionType.unknown:
        return _handleUnknownError(e);

      case DioExceptionType.badCertificate:
        return NetworkFailure('شهادة SSL غير صالحة');

      case DioExceptionType.connectionError:
        return NetworkFailure('فشل في الاتصال بالخادم');
    }
  }

  Failure _handleBadResponse(DioException e) {
    final statusCode = e.response?.statusCode;
    final responseData = e.response?.data;

    String message = _extractErrorMessage(responseData);

    switch (statusCode) {
      case 400:
        return ValidationFailure(message.isNotEmpty ? message : 'طلب غير صالح');
      case 401:
        return AuthFailure(message.isNotEmpty ? message : 'غير مصرح بالدخول');
      case 403:
        return AuthFailure(message.isNotEmpty ? message : 'ممنوع الوصول');
      case 404:
        return ServerFailure(
          message.isNotEmpty ? message : 'الخدمة غير متوفرة',
        );
      case 409:
        return ValidationFailure(
          message.isNotEmpty ? message : 'تعارض في البيانات',
        );
      case 422:
        return ValidationFailure(
          message.isNotEmpty ? message : 'بيانات غير صالحة',
        );
      case 429:
        return NetworkFailure('عدد الطلبات كبير جداً. يرجى المحاولة لاحقاً');
      case 500:
        return ServerFailure('خطأ داخلي في الخادم');
      case 502:
        return ServerFailure('بوابة غير صالحة');
      case 503:
        return ServerFailure('الخدمة غير متاحة حالياً');
      default:
        return ServerFailure('خطأ في الخادم: $statusCode');
    }
  }

  Failure _handleUnknownError(DioException e) {
    final error = e.error;

    if (error is SocketException) {
      return NetworkFailure('لا يوجد اتصال بالإنترنت');
    } else if (error is HandshakeException) {
      return NetworkFailure('خطأ في مصافحة SSL');
    } else {
      return NetworkFailure('خطأ في الاتصال: ${e.message}');
    }
  }

  Failure handleGenericError(dynamic e) {
    if (e is FormatException) {
      return ValidationFailure('تنسيق البيانات غير صحيح');
    } else if (e is SocketException) {
      return NetworkFailure('لا يوجد اتصال بالإنترنت');
    } else if (e is TimeoutException) {
      return NetworkFailure('انتهت مهلة الاتصال');
    } else if (e is TypeError) {
      return ValidationFailure('خطأ في نوع البيانات');
    } else {
      return ServerFailure('حدث خطأ غير متوقع: ${e.toString()}');
    }
  }

  String _extractErrorMessage(dynamic responseData) {
    try {
      if (responseData is String && responseData.isNotEmpty) {
        final json = jsonDecode(responseData);
        return json['message']?.toString() ??
            json['error']?.toString() ??
            json['detail']?.toString() ??
            '';
      } else if (responseData is Map) {
        return responseData['message']?.toString() ??
            responseData['error']?.toString() ??
            responseData['detail']?.toString() ??
            '';
      }
      return '';
    } catch (e) {
      return '';
    }
  }
}

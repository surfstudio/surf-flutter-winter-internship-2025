import 'package:dio/dio.dart';

abstract class BaseRemoteRepository {
  Future<T> handleException<T>(Future<T> Function() call) async {
    try {
      return await call();
    } on DioException catch (e) {
      throw _handleDioException(e);
    } on FormatException catch (e) {
      throw RepositoryException('Data format error: ${e.message}');
    } catch (e) {
      throw RepositoryException('Unexpected error: $e');
    }
  }

  RepositoryException _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return RepositoryException('Connection timeout. Please check your internet.');
      case DioExceptionType.badCertificate:
        return RepositoryException('Security error occurred.');
      case DioExceptionType.badResponse:
        return RepositoryException('Server error: ${e.response?.statusCode}');
      case DioExceptionType.cancel:
        return RepositoryException('Request cancelled');
      case DioExceptionType.connectionError:
        return RepositoryException('No internet connection');
      case DioExceptionType.unknown:
        return RepositoryException('Unknown error: ${e.message}');
    }
  }
}

class RepositoryException implements Exception {
  final String message;

  RepositoryException(this.message);

  @override
  String toString() => 'RepositoryException: $message';
}
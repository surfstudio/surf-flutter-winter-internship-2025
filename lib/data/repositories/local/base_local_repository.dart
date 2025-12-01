import 'dart:io';

import 'package:sqflite/sqflite.dart';

abstract class BaseLocalRepository {
  Future<T> handleLocalException<T>(Future<T> Function() call) async {
    try {
      return await call();
    } on DatabaseException catch (e) {
      throw LocalRepositoryException('Database error.');
    } on IOException catch (e) {
      throw LocalRepositoryException('Storage error.');
    } on FormatException catch (e) {
      throw LocalRepositoryException('Data format error: ${e.message}');
    } catch (e) {
      throw LocalRepositoryException('Unexpected local error: $e');
    }
  }
}

class LocalRepositoryException implements Exception {
  final String message;

  LocalRepositoryException(this.message);

  @override
  String toString() => 'LocalRepositoryException: $message';
}

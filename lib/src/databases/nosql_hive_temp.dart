import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nosql_dart/src/databases/nosql_abstract.dart';
import 'package:nosql_dart/src/nosql_error.dart';

class NoSqlHiveTemp implements NoSqlAbstract {
  NoSqlHiveTemp();

  @override
  NoSqlStateSemaphoreEnum noSqlSemaphore = NoSqlStateSemaphoreEnum.blank;

  Directory? tempDir;

  @override
  String get databaseName => 'mockito';

  @override
  Future<void> init({required String databaseName}) async {
    switch (noSqlSemaphore) {
      case NoSqlStateSemaphoreEnum.blank:
        tempDir = await Directory.systemTemp.createTemp();
        break;
      case NoSqlStateSemaphoreEnum.closed:
      case NoSqlStateSemaphoreEnum.initialized:
        tempDir = tempDir;
        break;
    }

    try {
      Hive.init(tempDir!.path);
      noSqlSemaphore = NoSqlStateSemaphoreEnum.initialized;
    } catch (_, stack) {
      throw NoSqlError('Cannot initialize database\n$stack');
    }
  }

  @override
  Future<void> close<C>({required C container}) {
    if (!isDatabaseReady()) {
      throw NoSqlError('Database not initialized');
    }
    Box box = container as Box;
    if (!box.isOpen) {
      throw NoSqlError('Box:${box.name} is not open');
    }
    return box.close();
  }

  @override
  bool isDatabaseReady() =>
      noSqlSemaphore == NoSqlStateSemaphoreEnum.initialized;

  @override
  Future<void> closeDatabase() {
    if (noSqlSemaphore != NoSqlStateSemaphoreEnum.initialized) {
      throw NoSqlError('Database not initialized');
    }
    noSqlSemaphore = NoSqlStateSemaphoreEnum.closed;
    return Hive.close();
  }

  @override
  Future<void> deleteFromDisk() async {
    if (noSqlSemaphore != NoSqlStateSemaphoreEnum.closed) {
      throw NoSqlError('Database not closed');
    }
    noSqlSemaphore = NoSqlStateSemaphoreEnum.blank;
    debugPrint('🧨 DELETED FROM DISK');
    return Hive.deleteFromDisk();
  }

  @override
  dynamic get<C>(
    String key, {
    required C fromContainer,
    dynamic defaultValue,
  }) {
    final box = fromContainer as Box;
    if (!box.isOpen) {
      throw NoSqlError('Box:${box.name} is not open');
    }
    return box.get(key, defaultValue: defaultValue);
  }

  @override
  Future<void> put<C, T>(String key, T value, {required C intoContainer}) {
    final box = intoContainer as Box;
    if (!box.isOpen) {
      throw NoSqlError('Box:${box.name} is not open');
    }
    return (intoContainer as Box).put(key, value);
  }

  @override
  Future<C> openContainer<C, T>({required String name}) {
    if (!isDatabaseReady()) {
      throw NoSqlError('❌ Database not initialized');
    }
    return Hive.openBox<T>(name) as Future<C>;
  }
}

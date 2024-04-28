import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nosql_dart/src/databases/nosql_abstract.dart';
import 'package:nosql_dart/src/nosql_error.dart';

class NoSqlHiveTemp implements NoSqlAbstract {
  NoSqlHiveTemp();

  NoSqlStateEnum? noSqlState;

  Directory? tempDir;

  @override
  String get databaseName => 'mockito';

  @override
  Future<void> init({required String databaseName}) async {
    if (noSqlState == null) {
      tempDir = await Directory.systemTemp.createTemp();
    } else if (noSqlState == NoSqlStateEnum.closed) {
      tempDir = tempDir;
    } else if (noSqlState == NoSqlStateEnum.initialized) {
      throw NoSqlError('🛑 $databaseName already initialized');
    }

    try {
      Hive.init(tempDir!.path);
      noSqlState = NoSqlStateEnum.initialized;
    } catch (error, stack) {
      debugPrint('⛔️ ‼️Error initializing database: $error\n$stack');
      throw NoSqlError('Cannot initialize database');
    }
  }

  @override
  Future<void> close<C>({required C container}) {
    if (noSqlState != NoSqlStateEnum.initialized) {
      throw NoSqlError('Database not initialized');
    }
    Box box = container as Box;
    if (!box.isOpen) {
      throw NoSqlError('Box:${box.name} is not open');
    }
    return box.close();
  }

  @override
  Future<void> closeDatabase() {
    if (noSqlState != NoSqlStateEnum.initialized) {
      throw NoSqlError('Database not initialized');
    }
    noSqlState = NoSqlStateEnum.closed;
    return Hive.close();
  }

  @override
  Future<void> deleteFromDisk() async {
    if (noSqlState != NoSqlStateEnum.closed) {
      throw NoSqlError('Database not closed');
    }
    noSqlState = null;

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
    if (noSqlState != NoSqlStateEnum.initialized) {
      throw NoSqlError('❌ Database not initialized');
    }
    return Hive.openBox<T>(name) as Future<C>;
  }
}

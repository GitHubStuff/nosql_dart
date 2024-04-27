import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'nosql_abstract.dart';

class NoSqlHive implements NoSqlAbstract {
  @override
  final String databaseName = '<mockito>';

  NoSqlHive();

  @override
  Future<void> init({required String databaseName}) async {
    Directory? dir = await getApplicationDocumentsDirectory();
    final String path =
        '${dir.path}/${NoSqlAbstract.hiveDirectory}/$databaseName';
    Hive.init(path);
  }

  @override
  Future<void> close<C>({required C container}) {
    // TODO: implement close
    throw UnimplementedError();
  }

  @override
  Future<void> closeDatabase() {
    // TODO: implement closeDatabase
    throw UnimplementedError();
  }

  @override
  Future<void> deleteFromDisk() async {
    try {
      await Hive.deleteBoxFromDisk(databaseName);
    } catch (error, stack) {
      debugPrint('❌ Error deleting database: $error\n$stack');
    }

    @override
    Future<T>? get<C, T>(String key,
        {required C fromContainer, T? defaultValue}) {
      // TODO: implement get
      throw UnimplementedError();
    }

    @override
    Future<void> openContainer({required String name}) {
      // TODO: implement openContainer
      throw UnimplementedError();
    }

    @override
    Future<void> put<C, T>(String key, T value, {required C intoContainer}) {
      // TODO: implement put
      throw UnimplementedError();
    }

    @override
    Future<C> retrieveContainer<C, T>({required String name}) {
      // TODO: implement retrieveContainer
      throw UnimplementedError();
    }
  }

  @override
  Future<void> put<C, T>(String key, T value, {required C intoContainer}) {
    // TODO: implement put
    throw UnimplementedError();
  }

  @override
  dynamic get<C>(String key, {required C fromContainer, defaultValue}) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<C> openContainer<C, T>({required String name}) {
    // TODO: implement openContainer
    throw UnimplementedError();
  }
}

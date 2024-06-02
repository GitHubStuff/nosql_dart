import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'nosql_abstract.dart';
import 'nosql_hive_temp.dart';

class NoSqlHive extends NoSqlHiveTemp {
  @override
  late final String databaseName;

  NoSqlHive();

  @override
  Future<void> init({required String databaseName}) async {
    this.databaseName = databaseName;
    Directory? dir = await getApplicationDocumentsDirectory();
    final String path =
        '${dir.path}/${NoSqlAbstract.hiveDirectory}/$databaseName';
    Hive.init(path);
    noSqlSemaphore = NoSqlStateSemaphoreEnum.initialized;
  }

  @override
  bool isDatabaseReady() =>
      noSqlSemaphore == NoSqlStateSemaphoreEnum.initialized;
}

import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'nosql_abstract.dart';

class NoSqlHive extends NoSqlAbstract {
  @override
  final String databaseName;

  NoSqlHive({required this.databaseName});

  @override
  Future<void> close() {
    // TODO: implement close
    throw UnimplementedError();
  }

  @override
  Future<void> deleteFromDisk() {
    // TODO: implement deleteFromDisk
    throw UnimplementedError();
  }

  @override
  Future<T>? get<T>(String key, {T? defaultValue}) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<void> put<T>(String key, T value) {
    // TODO: implement put
    throw UnimplementedError();
  }

  @override
  Future<void> initialize({required String databaseName}) async {
    getApplicationDocumentsDirectory().then(
      (Directory dir) {
        final String databasePath =
            '${dir.path}/${NoSqlAbstract.hiveDirectory}/${databaseName.baseName}';
        Hive.init(databasePath);
      },
    );
  }

  @override
  Future<void> openCollection<T>({required String collectionName}) async {
    //Box? box = await Hive.openBox<T>(collectionName);
    throw UnimplementedError();
  }
}

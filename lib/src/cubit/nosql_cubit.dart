import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../nosql_data.dart';
import '../nosql_enum.dart';

part 'nosql_state.dart';

class NoSqlCubit extends Cubit<NoSqlState> {
  final NoSqlStoreStyle style;

  static NoSqlCubit? _instance;

  // Private constructor to enforce singleton pattern
  NoSqlCubit._(this.style) : super(NoSqlStateInitial());

  // Generic private factory method to handle singleton logic
  static NoSqlCubit _getInstance(
    NoSqlStoreStyle style, [
    String databaseName = "",
  ]) {
    if (_instance != null && _instance!.style != style) {
      throw Exception(
          "NoSqlCubit is already initialized with a different store type.");
    }
    return _instance ??= NoSqlCubit._(style).._setup(databaseName);
  }

  // Public factory methods for specific store types
  static NoSqlCubit hiveDevice({required String databaseRootName}) =>
      _getInstance(NoSqlStoreStyle.bHiveDevice, databaseRootName);
  static NoSqlCubit hiveMemory() => _getInstance(NoSqlStoreStyle.bHiveMemory);
  static NoSqlCubit inMemory() => _getInstance(NoSqlStoreStyle.inMemory);

  @override
  Future<void> close() async {
    await super.close();
    _instance = null;
  }

  Future<void> closeNoSql() async {
    emit(NoSqlStateClosed());
  }

  Future<void> _setup(String databaseName) async {
    // Setup logic, e.g., initializing a database
    emit(NoSqlStateReady());
  }
}

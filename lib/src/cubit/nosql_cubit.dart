import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;

import '../databases/nosql_abstract.dart';

part 'nosql_state.dart';

abstract class NoSqlCubitAbstract {
  Future closeNoSql();
  Future<void> initialize(String databaseName);
  Future<void> openCollection(String collectionName);
}

class NoSqlCubit extends Cubit<NoSqlState> implements NoSqlCubitAbstract {
  NoSqlCubit({
    required this.noSqlProvider,
    required this.databaseName,
  }) : super(NoSqlStateStart());

  final NoSqlAbstract noSqlProvider;
  final String databaseName;

  @override
  Future<void> closeNoSql() async {
    try {
      await noSqlProvider.close();
      emit(NoSqlStateClosed());
    } catch (error) {
      emit(NoSqlStateError('Error closing NoSqlProvider', reason: error));
    }
  }

  @override
  Future<void> initialize(String databaseName) async {
    try {
      await noSqlProvider.initialize(databaseName: databaseName);
      emit(NoSqlStateInitialized());
    } catch (error) {
      emit(NoSqlStateError('Error initializing NoSqlProvider', reason: error));
    }
  }

  @override
  Future<void> openCollection(String collectionName) async {
    try {
      await noSqlProvider.openCollection(collectionName: collectionName);
      emit(NoSqlStateReady());
    } catch (error) {
      emit(NoSqlStateError('Error opening collection', reason: error));
    }
  }
}

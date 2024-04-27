import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;

import '../databases/nosql_abstract.dart';

part 'nosql_state.dart';

abstract class NoSqlCubitAbstract {}

class NoSqlCubit extends Cubit<NoSqlState> implements NoSqlCubitAbstract {
  NoSqlCubit({
    required this.noSqlProvider,
    required this.databaseName,
  }) : super(NoSqlStateStart());

  final NoSqlAbstract noSqlProvider;
  final String databaseName;
}

part of 'nosql_cubit.dart';

@immutable
sealed class NoSqlState {}

final class NoSqlStateInitial extends NoSqlState {}

final class NoSqlStateReady extends NoSqlState {}

final class NoSqlStateData extends NoSqlState {
  final NoSqlData data;

  NoSqlStateData(this.data);
}

final class NoSqlStateClosed extends NoSqlState {}

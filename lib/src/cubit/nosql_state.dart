part of 'nosql_cubit.dart';

@immutable
sealed class NoSqlState extends Equatable {
  @override
  String toString() => runtimeType.toString();
}

final class NoSqlStateClosed extends NoSqlState {
  NoSqlStateClosed();
  @override
  List<Object?> get props => [];
}

final class NoSqlStateData extends NoSqlState {
  final dynamic data;

  NoSqlStateData(this.data);
  @override
  List<Object?> get props => [data];
}

final class NoSqlStateError extends NoSqlState {
  final String message;
  final dynamic reason;
  NoSqlStateError(this.message, {this.reason});

  @override
  List<Object?> get props => [message, reason];
}

final class NoSqlStateInitialized extends NoSqlState {
  @override
  List<Object?> get props => [];
}

final class NoSqlStateReady extends NoSqlState {
  @override
  List<Object?> get props => [];
}

final class NoSqlStateStart extends NoSqlState {
  @override
  List<Object?> get props => [];
}

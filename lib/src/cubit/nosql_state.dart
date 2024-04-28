// part of 'nosql_cubit.dart';

// @immutable
// sealed class NoSqlState extends Equatable {
//   @override
//   List<Object?> get props => [];

//   @override
//   String toString() => runtimeType.toString();
// }

// final class NoSqlStateClosed extends NoSqlState {}

// final class NoSqlStateData extends NoSqlState {
//   final dynamic data;

//   NoSqlStateData(this.data);
//   @override
//   List<Object?> get props => [data];
// }

// final class NoSqlStateError extends NoSqlState {
//   final String message;
//   final dynamic reason;
//   NoSqlStateError(this.message, {this.reason});

//   @override
//   List<Object?> get props => [message, reason];
// }

// final class NoSqlStateInitialized extends NoSqlState {}

// final class NoSqlStateReady extends NoSqlState {}

// final class NoSqlStateStart extends NoSqlState {}

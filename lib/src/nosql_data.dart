import 'cubit/nosql_cubit.dart';
import 'nosql_enum.dart';

class NoSqlData {
  final NoSqlState state;
  final Map<String, dynamic>? data;
  final NoSqlAction action;
  final String noSqlKey;

  NoSqlData(
      {required this.state,
      this.data,
      required this.action,
      required this.noSqlKey});
}

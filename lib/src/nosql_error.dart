class NoSqlError extends Error {
  final String message;
  NoSqlError(this.message) : super();
  @override
  String toString() => 'NoSqlError: $message';
}

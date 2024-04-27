class NoSqlError extends Error {
  final String message;
  NoSqlError(this.message);
  @override
  String toString() => 'NoSqlError: $message';
}

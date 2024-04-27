enum NoSqlStateEnum { initialized, closed }

abstract class NoSqlAbstract {
  /// The directory where the Hive databases are stored.
  static const String hiveDirectory = 'hive_icfy_databases_v1r373663';

  String get databaseName;

  /// Class methods.
  Future<void> init({required String databaseName});
  Future<C> openContainer<C, T>({required String name});
  dynamic get<C>(String key, {required C fromContainer, defaultValue});
  Future<void> put<C, T>(String key, T value, {required C intoContainer});
  Future<void> close<C>({required C container});
  Future<void> closeDatabase();
  Future<void> deleteFromDisk();
}

/// Extension on String to get the base name of a file.
extension FileName on String {
  String get baseName {
    // Splitting the string by '/' and getting the last part.
    var fileName = split('/').last;

    // Checking if the fileName contains '.' and removing the extension.
    int dotIndex = fileName.lastIndexOf('.');
    if (dotIndex != -1) fileName = fileName.substring(0, dotIndex);

    // Removing all non-alphanumeric characters using a regular expression.
    fileName = fileName.replaceAll(RegExp(r'[^A-Za-z0-9]'), '');

    return fileName;
  }
}

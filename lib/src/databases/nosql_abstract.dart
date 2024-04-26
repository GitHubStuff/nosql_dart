/// Defines the interface for a persisted storage solution.
///
/// This abstract class specifies the essential operations that any concrete implementation
/// of a persisted store must support, such as retrieving, inserting, and deleting data,
/// as well as managing the store's lifecycle.
abstract class NoSqlAbstract {
  /// The directory where the Hive databases are stored.
  static const String hiveDirectory = 'hive_icfy_databases_v1r373663';

  String get databaseName;

  /// Closes the store and releases any resources or locks it might be holding.
  ///
  /// This is typically used to gracefully shutdown the store or prepare it for deletion.
  Future<void> close();

  /// Deletes the store from the device's disk, effectively removing all stored data.
  ///
  /// Use this operation with caution as it will result in the loss of all persisted data.
  Future<void> deleteFromDisk();

  Future<void> initialize({required String databaseName});

  Future<void> openCollection<T>({required String collectionName});

  /// Retrieves a value associated with the given [key] from the store.
  ///
  /// If the key is not found, returns the [defaultValue], which is `null` by default.
  Future<T>? get<T>(String key, {T? defaultValue});

  /// Inserts or updates a value in the store, associating it with the specified [key].
  ///
  /// If the key already exists, its value is updated. Otherwise, a new key-value pair is created.
  Future<void> put<T>(String key, T value);
}

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

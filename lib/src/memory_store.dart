import 'on_device_store.dart';

/// A `MemoryStore` class that implements an in-memory storage system.
/// This class extends `OnDeviceStore` to provide a quick and volatile storage solution,
/// with operations that mimic persistent storage without the I/O overhead.
class MemoryStore extends OnDeviceStore {
  /// A map to hold key-value pairs in memory.
  final Map<dynamic, dynamic> _records = {};

  /// The name of the database. Used for identification purposes.
  final String dbName;

  /// Indicates whether the store is available for operations.
  /// Operations are not allowed if the store is marked as unavailable.
  bool _isAvailable = true;

  /// Constructs a `MemoryStore` with the given database name.
  ///
  /// The `dbName` parameter is required to uniquely identify the memory store.
  MemoryStore({required this.dbName});

  @override

  /// Closes the memory store and marks it as unavailable for further operations.
  Future<void> close() async {
    _checkAvailability();
    _isAvailable = false;
  }

  @override

  /// Deletes all records from the store and marks it as unavailable.
  ///
  /// This simulates deleting the store from disk by clearing the in-memory records.
  Future<void> deleteFromDisk() async {
    _checkAvailability();
    _records.clear();
    _isAvailable = false;
  }

  @override

  /// Retrieves a value from the memory store by its key.
  ///
  /// Returns the value associated with the key if it exists; otherwise, returns `defaultValue`.
  /// The operation checks for store availability before proceeding.
  dynamic get(dynamic key, {dynamic defaultValue}) {
    _checkAvailability();
    return _records[key] ?? defaultValue;
  }

  @override

  /// Inserts or updates a key-value pair in the memory store.
  ///
  /// Ensures the store is available before performing the operation.
  Future<void> put(dynamic key, dynamic value) async {
    _checkAvailability();
    _records[key] = value;
  }

  /// Checks if the store is available for operations.
  ///
  /// Throws an `OnDeviceException` if the store is unavailable,
  /// indicating that operations cannot be performed.
  void _checkAvailability() {
    if (!_isAvailable) {
      throw const OnDeviceException(
          message: 'Operation attempted on an unavailable store');
    }
  }

  @override

  /// Returns a string representation of the `MemoryStore`.
  ///
  /// Includes the database name, number of records, and availability status.
  String toString() {
    return 'MemoryStore{dbName: $dbName, records: ${_records.length}, isAvailable: $_isAvailable}';
  }

  @override

  /// A unique tag for the memory store derived from the database name.
  String get tag => dbName;

  @override

  /// Indicates whether the store is unavailable for operations.
  ///
  /// It's a negation of the `_isAvailable` flag.
  bool get isUnavailable => !_isAvailable;
}

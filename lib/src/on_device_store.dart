import 'package:flutter/material.dart';

/// Global flag to control the logging of stack traces.
///
/// It's advisable to encapsulate this within a configuration class for better context and control.
bool doStackTrace = false;

/// Represents an exception that is thrown when an attempt is made to access
/// a persisted store that is not currently available.
@immutable
class OnDeviceException implements Exception {
  /// The message that describes the error. Defaults to indicating that the persisted store is not available.
  final String message;

  /// Constructs an instance of `OnDeviceException` with an optional error [message].
  const OnDeviceException({this.message = 'PersistedStore is not available.'});

  @override

  /// Returns a string representation of the exception, including the error message.
  String toString() => 'OnDeviceException: $message';
}

/// Defines the interface for a persisted storage solution.
///
/// This abstract class specifies the essential operations that any concrete implementation
/// of a persisted store must support, such as retrieving, inserting, and deleting data,
/// as well as managing the store's lifecycle.
abstract class OnDeviceStore {
  /// Determines whether the store is currently unavailable for operations.
  ///
  /// Implementations should return `true` if the store cannot be accessed or used.
  bool get isUnavailable;

  /// Retrieves a value associated with the given [key] from the store.
  ///
  /// If the key is not found, returns the [defaultValue], which is `null` by default.
  dynamic get(dynamic key, {dynamic defaultValue});

  /// Closes the store and releases any resources or locks it might be holding.
  ///
  /// This is typically used to gracefully shutdown the store or prepare it for deletion.
  Future<void> close();

  /// Deletes the store from the device's disk, effectively removing all stored data.
  ///
  /// Use this operation with caution as it will result in the loss of all persisted data.
  Future<void> deleteFromDisk();

  /// Inserts or updates a value in the store, associating it with the specified [key].
  ///
  /// If the key already exists, its value is updated. Otherwise, a new key-value pair is created.
  Future<void> put(dynamic key, dynamic value);

  /// A unique identifier for the store, often used for debugging or logging purposes.
  ///
  /// This should uniquely identify the instance or type of the persisted store.
  String get tag;
}

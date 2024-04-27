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

/*
/// A Dart library for working with files and directories using a simple, synchronous API.
library;

import 'dart:io';

/// Provides a Flutter integration for the Hive NoSQL database,
/// enabling easy data storage on the device.
import 'package:hive_flutter/hive_flutter.dart';

/// Custom abstraction for storing data on the device,
/// which `BHiveDeviceStore` implements.
import 'on_device_store.dart';

/// Directory name under which Hive stores its data.
const String _subDir = 'hive';

/// Default name for the Hive box, used for storing key-value pairs.
const String _boxName = 'com_icodeforyou_1e1e40en86g61m49ae0d12b26r373663';

/// Enum to distinguish between in-memory and on-device storage modes
/// for the BHiveStore.
enum BHiveStoreEnum {
  inMemory(true),

  /// Indicates the store is in memory, faster but not persistent.
  onDevice(false);

  /// Indicates the store is on the device, persistent across app restarts.

  /// Flag to check if the storage is in memory.
  final bool isMemory;

  const BHiveStoreEnum(this.isMemory);
}

/// Implementation of `OnDeviceStore` for Hive database storage.
class BHiveDeviceStore extends OnDeviceStore {
  /// Temporary directory for in-memory storage. Nullable for on-device storage.
  Directory? _tempDir;

  /// The Hive box used for storing data.
  late final Box _box;

  /// Type of storage being used, in-memory or on-device.
  late final BHiveStoreEnum _store;

  /// A tag to identify the store, useful for debugging.
  @override
  final String tag;

  /// Private constructor for `BHiveDeviceStore` to set up the store.
  BHiveDeviceStore._internal(
    this._box,
    this._store, {
    Directory? tempDir,
    required this.tag,
  }) : _tempDir = tempDir;

  /// Factory method to set up an in-memory Hive store.
  /// Returns an instance of `BHiveDeviceStore`.
  static Future<BHiveDeviceStore> inMemorySetup<T>({
    String hiveBox = _boxName,
  }) async {
    assert(hiveBox.isNotEmpty, 'hiveBox cannot be empty');
    Directory tempDir = Directory.systemTemp.createTempSync();
    Hive.init(tempDir.path);
    Box box = await Hive.openBox<T>(hiveBox);
    return BHiveDeviceStore._internal(
      box,
      BHiveStoreEnum.inMemory,
      tempDir: tempDir,
      tag: tempDir.path.split('/').last,
    );
  }

  /// Factory method to set up an on-device Hive store.
  /// Returns an instance of `BHiveDeviceStore`.
  static Future<BHiveDeviceStore> onDeviceSetUp<T>({
    String? hiveDir,
    String hiveBox = _boxName,
  }) async {
    await Hive.initFlutter(hiveDir ?? _subDir);
    Box box = await Hive.openBox<T>(hiveBox);
    return BHiveDeviceStore._internal(
      box,
      BHiveStoreEnum.onDevice,
      tag: hiveDir ?? _subDir,
    );
  }

  /// Closes the Hive box and, if in-memory, deletes the temporary directory.
  @override
  Future<void> close() async {
    if (_box.isOpen) {
      await _box.close();
      if (_store.isMemory) {
        _tempDir?.deleteSync(recursive: true);
        _tempDir = null;
      }
    }
  }

  /// Deletes the box from the disk if it's on-device storage.
  @override
  Future<void> deleteFromDisk() async {
    if (!_store.isMemory && _box.isOpen) await _box.deleteFromDisk();
  }

  /// Retrieves a value from the Hive box by key, with an optional default value.
  @override
  dynamic get(dynamic key, {dynamic defaultValue}) =>
      _box.get(key, defaultValue: defaultValue);

  /// Inserts or updates a key-value pair in the Hive box.
  @override
  Future<void> put(dynamic key, dynamic value) async =>
      await _box.put(key, value);

  /// Returns a string representation of the `BHiveDeviceStore`.
  @override
  String toString() =>
      'BHiveDeviceStore{box: $_box, dir: $_tempDir, store: $_store}';

  /// Checks if the store is unavailable (either because the directory or box is not accessible).
  bool get unAvailable => _tempDir == null || !_box.isOpen;

  /// Alias for `unAvailable` to match naming conventions.
  @override
  bool get isUnavailable => _tempDir == null || !_box.isOpen;
}
*/
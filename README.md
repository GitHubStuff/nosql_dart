# BHiveStorage

A Flutter package that simplifies working with local storage using the Hive NoSQL database. It provides a unified API for in-memory and on-device storage, making data persistence and retrieval straightforward and efficient. This package is ideal for Flutter applications needing a lightweight, yet powerful local storage solution.

## Features

- **Easy Integration**: Seamlessly integrates with your Flutter projects.
- **Dual Storage Options**: Supports both in-memory and on-device storage for flexibility in data persistence.
- **Simple API**: Offers a simple, synchronous API for storing and retrieving data.
- **Custom Abstractions**: Includes custom abstractions for a more intuitive interaction with the storage system.

## Installation

To use BHiveStorage in your Flutter project, add it as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  nosql_dart:
    git: https://github.com/GitHubStuff/nosql_dart.git
```

Before using BHiveStorage, you must initialize Hive. This is typically done in the main.dart file of your Flutter project.

For on-device storage, ensure you initialize Hive with Hive.initFlutter() inside the main() function:

```dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'your_project_imports.dart'; // Import your project files

/// Part of NoSQL database store.
late final OnDeviceStore onDeviceStore;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  onDeviceStore = await BHiveDeviceStore.onDeviceSetUp();
  runApp(MyApp());
}
```

For in-memory storage, initialization is handled internally when you use the BHiveDeviceStore.inMemorySetup() method.

## Usage

Creating a Store

### On-Device Store

```dart
import 'package:bhive_storage/bhive_storage.dart';

Future<void> setupOnDeviceStore() async {
  BHiveDeviceStore store = await BHiveDeviceStore.onDeviceSetUp();
  // Use the store for on-device persistence
}
```

### In-Memory Store

```dart
import 'package:bhive_storage/bhive_storage.dart';

Future<void> setupInMemoryStore() async {
  BHiveDeviceStore store = await BHiveDeviceStore.inMemorySetup();
  // Use the store for in-memory operations
}
```

## Basic Operations

### Storing Data

```dart
await store.put('key', 'value');
```

### Retrieving Data

```dart
var value = store.get('key', defaultValue: 'default');
```

### Deleting Data

```dart
await store.delete('key');
```

### To clear the store

```dart
await store.deleteFromDisk();
```

### Closing the store

```dart
await store.close();
```

## Finally

Be kind to each other.

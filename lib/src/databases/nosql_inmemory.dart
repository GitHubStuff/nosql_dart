// import 'nosql_abstract.dart';

// typedef NoSqlMap<T> = Map<String, Map<String, T>>;

// enum NoSqlInMemoryEnum {
//   initialized,
//   closed,
// }

// class NoSqlInMemory implements NoSqlAbstract {
//   Set _collections = <String>{};

//   NoSqlMap? _data;
//   NoSqlInMemoryEnum? _memoryState;

//   @override
//   String databaseName = '<memory>';

//   @override
//   Future<void> close() async {
//     if (_memoryState == null) throw StateError('NoSqlInMemory not initialized');
//     _data = null;
//     _memoryState = NoSqlInMemoryEnum.closed;
//   }

//   @override
//   Future<void> deleteFromDisk() async {
//     if (_memoryState == null) throw StateError('NoSqlInMemory not initialized');
//     if (_memoryState != NoSqlInMemoryEnum.closed) {
//       throw StateError('NoSqlInMemory is not closed');
//     }
//     _data = null;
//     _memoryState = NoSqlInMemoryEnum.initialized;
//   }

//   @override
//   Future<T>? get<T>(String key, {T? defaultValue}) async {
//     if (_memoryState != NoSqlInMemoryEnum.openedCollection) {
//       throw StateError('NoSqlInMemory collection not opened');
//     }
//     return _data![_data!.keys.first]![key] ?? defaultValue;
//   }

//   @override
//   Future<void> put<T>(String key, T value) async {
//     if (_memoryState != NoSqlInMemoryEnum.openedCollection) {
//       throw StateError('NoSqlInMemory collection not opened');
//     }
//     try {
//       _data![_data!.keys.first]![key] = value;
//     } catch (error) {
//       throw StateError('Cannot put value in NoSqlInMemory for key: $key');
//     }
//   }

//   @override
//   Future<void> initialize({required String databaseName}) async {
//     _data = NoSqlMap();
//     _memoryState = NoSqlInMemoryEnum.initialized;
//   }

//   @override
//   Future<void> openCollection({required String collectionName}) async {
//     if (_data == null) {
//       throw StateError('NoSqlInMemory not initialized');
//     } else if (_data!.containsKey(collectionName)) {
//       throw StateError('Collection already exists');
//     } else {
//       _data![collectionName] = {};
//       _memoryState = NoSqlInMemoryEnum.openedCollection;
//     }
//   }

//   @override
//   Future<void> retrieveColletion<C, T>({required String collectionName}) {
//     // TODO: implement retrieveColletion
//     throw UnimplementedError();
//   }
// }

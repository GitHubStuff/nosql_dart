import 'package:flutter_test/flutter_test.dart';
import 'package:nosql_dart/nosql_dart.dart';

void main() {
  group('NoSqlInMemory Tests:', () {
    late NoSqlInMemory database;

    setUp(() async {
      database = NoSqlInMemory();
    });

    test('setup', () {
      expect(database.databaseName, '<memory>');
    });

    test('Delete from disk should throw error', () {
      expect(() => database.deleteFromDisk(), throwsStateError);
    });

    test('Opening a collection should throw error', () async {
      //SKIP: database.initialize(databaseName: 'testDatabase');
      expect(() => database.openCollection(collectionName: 'testCollection'),
          throwsStateError);
    });

    test('Opening a collection', () async {
      database.initialize(databaseName: 'testDatabase');
      expect(database.openCollection(collectionName: 'testCollection'),
          isA<Future<void>>());
    });

    test('Close should throw', () async {
      //SKIP: database.initialize(databaseName: 'testDatabase');
      expect(() => database.close(), throwsStateError);
    });

    test('Delete from Disk should throw', () async {
      expect(database.deleteFromDisk(), throwsStateError);
    });

    test('Delete from Disk should throw [collections still open]', () async {
      await database.initialize(databaseName: 'testDatabase');
      await database.openCollection(collectionName: 'testCollection');
      expect(database.deleteFromDisk(), throwsStateError);
    });

    test('Delete from Disk should NOT throw', () async {
      await database.initialize(databaseName: 'testDatabase');
      await database.openCollection(collectionName: 'testCollection');
      await database.close();
      expect(database.deleteFromDisk(), completes);
    });

    test('Put should throw', () {
      expect(database.put('key1', 'value1'), throwsStateError);
    });

    test('Put should NOT throw', () async {
      await database.initialize(databaseName: 'testDatabase');
      await database.openCollection(collectionName: 'testCollection');
      expect(database.put<String>('key1', 'value1'), completes);
    });

    test('Putting and getting values should Not throw', () async {
      await database.initialize(databaseName: 'testDatabase');
      await database.openCollection(collectionName: 'testCollection');
      await database.put<String>('key1', 'value1');
      String? result = await database.get<String>('key1');
      expect(result, 'value1');
    });

    test('Getting values with default', () async {
      await database.initialize(databaseName: 'testDatabase');
      await database.openCollection(collectionName: 'testCollection');
      await database.put<String>('key1', 'value1');
      int? result =
          await database.get<int>('nonexistent_key', defaultValue: 10);
      expect(result, 10);
    });

    test('Deleting from disk should clear the store', () async {
      await database.initialize(databaseName: 'testDatabase');
      await database.openCollection(collectionName: 'testCollection');
      await database.put<String>('key1', 'value1');
      await database.close();
      await database.deleteFromDisk();
      expect(database.get<String>('key1'), throwsStateError);
    });

    test('Close with improper state', () async {
      //SKIP: database.initialize(databaseName: 'testDatabase');
      expect(database.close(), throwsStateError);
    });

    test('Proper close', () async {
      await database.initialize(databaseName: 'testDatabase');
      await database.openCollection(collectionName: 'testCollection');
      expect(database.close(), completes);
    });
  });
}

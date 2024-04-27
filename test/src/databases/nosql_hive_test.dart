import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'nosql_hive_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('NoSqlHive Initialization Tests:', () {
    late MockHive database;
    setUp(() async => database = MockHive());

    tearDown(() async {
      try {
        await database.closeDatabase();
        await database.deleteFromDisk();
      } catch (_) {}
    });

    test('Initialize database', () async {
      expectLater(database.init(databaseName: 'mockito'), completes);
      expect(database.databaseName, 'mockito');
    });

    test('Initialize database twice to confirm error', () async {
      await database.init(databaseName: 'mockito');
      expectLater(database.init(databaseName: 'mockito'), throwsStateError);
    });
  });

  group('NoSqlHive Disk Operations:', () {
    late MockHive database;

    setUp(() async {
      database = MockHive();
      await database.init(databaseName: 'mockito');
    });

    test('Delete from disk successfully', () async {
      expect(database.closeDatabase(), completes);
      expect(database.deleteFromDisk(), completes);
    });

    test('Delete from disk without closing', () async {
      expect(database.deleteFromDisk(), throwsStateError);
    });
  });

  group('NoSqlHive Container Operations:', () {
    late MockHive database;

    setUp(() async => database = MockHive());

    test('Open collection before init should fail', () async {
      expectLater(
        () => database.openContainer<Box, String>(name: 'mock_box'),
        throwsStateError,
      );
    });

    test('Open collection after init should succeed', () async {
      await database.init(databaseName: 'mockito');
      expect(
        database.openContainer<Box, String>(name: 'mock_box'),
        completes,
      );
    });

    test('retrieve and verify Container', () async {
      await database.init(databaseName: 'mockito');
      Box<String> stringBox =
          await database.openContainer<Box<String>, String>(name: 'mock_box');
      expect(stringBox, isA<Box<String>>());
    });
  });

  group('NoSqlHive Data Manipulation:', () {
    late MockHive database;

    setUp(() async {
      database = MockHive();
      await database.init(databaseName: 'mockito');
    });

    test('PUT and GET data', () async {
      Box<String> stringBox =
          await database.openContainer<Box<String>, String>(name: 'mock_box');
      await database.put<Box, String>('key1', 'value1',
          intoContainer: stringBox);
      String result = database.get<Box>('key1', fromContainer: stringBox);
      expect(result, 'value1');
    });
  });

  group('NoSqlHive Lifecycle:', () {
    late MockHive database;

    setUp(() async => database = MockHive());

    test('PUT, close, re-init, and GET', () async {
      const String dbName = 'complx';
      await database.init(databaseName: dbName);
      Box<String> stringBox = await database.openContainer<Box<String>, String>(
          name: 'mockcontainer');
      await database.put<Box, String>('key1', 'value1',
          intoContainer: stringBox);
      await database.closeDatabase();

      await database.init(databaseName: dbName);
      Box<String> reopenedBox = await database
          .openContainer<Box<String>, String>(name: 'mockcontainer');
      String? result = database.get<Box>('key1', fromContainer: reopenedBox);
      expect(result, 'value1');
    });
  });
}

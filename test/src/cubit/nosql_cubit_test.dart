/*
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:nosql_dart/nosql_dart.dart';

late NoSqlInMemory mockProvider;
late NoSqlCubit testCubit;

void main() {
  setUp(() {
    mockProvider = NoSqlInMemory();
    testCubit = NoSqlCubit(noSqlProvider: mockProvider, databaseName: 'test');
  });
  tearDown(() {});

  group('NoSqlCubit - Creating cubit:', () {
    test('Should return an instance of NoSqlCubit', () {
      expect(testCubit, isA<NoSqlCubit>());
      expect(mockProvider.databaseName, equals('<memory>'));
    });
    blocTest<NoSqlCubit, NoSqlState>(
      'Should return status of notInitialized',
      build: () => testCubit,
      act: (cubit) => cubit.initialize('test'),
      expect: () => [NoSqlStateInitialized()],
    );
  });

  group('NoSql methods:', () {
    blocTest<NoSqlCubit, NoSqlState>(
      'Try to close un-initialized NoSqlProvider',
      build: () => testCubit,
      act: (cubit) {
        cubit.closeNoSql();
      },
      expect: () => [
        isA<NoSqlStateError>(),
      ],
    );
  });
}
*/
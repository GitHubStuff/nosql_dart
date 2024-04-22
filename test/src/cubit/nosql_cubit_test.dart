import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:nosql_dart/src/cubit/nosql_cubit.dart';

void main() {
  group('NoSqlCubit', () {
    tearDown(() {
      //NoSqlCubit._instance = null; // Ensures _instance is reset after each test
    });

    test('should enforce singleton pattern with hiveDevice', () {
      var cubit1 = NoSqlCubit.hiveMemory();
      var cubit2 = NoSqlCubit.hiveMemory();
      expect(identical(cubit1, cubit2), isTrue);
    });

    test('throws exception when trying to create a different type of instance',
        () {
      NoSqlCubit.hiveMemory();
      expect(() => NoSqlCubit.inMemory(), throwsA(isA<Exception>()));
    });

    blocTest<NoSqlCubit, NoSqlState>(
      'emits [NoSqlStateClosed] when closed',
      build: () => NoSqlCubit.hiveMemory(),
      act: (cubit) => cubit.closeNoSql(),
      expect: () => [isA<NoSqlStateClosed>()],
    );

    // Additional tests can include the specific behaviors of the _setup method and other business logic
  });
}

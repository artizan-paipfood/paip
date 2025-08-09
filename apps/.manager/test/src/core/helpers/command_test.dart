import 'package:flutter_test/flutter_test.dart';

import 'package:manager/src/core/helpers/command.dart';

void main() {
  group('Command0.execute', () {
    test('Deve retornar um suceso de String', () async {
      String? onSuccessValue;
      Object? error;
      bool? onFinallyCalled;

      final result = await Command0.execute<String>(
        () async {
          await Future.delayed(const Duration(milliseconds: 100));
          return 'teste';
        },
        onSuccess: (r) => onSuccessValue = r,
        onError: (e, s) => error = e,
        onFinally: () => onFinallyCalled = true,
      );

      expect(result, equals('teste'));
      expect(onSuccessValue, equals('teste'));
      expect(error, isNull);
      expect(onFinallyCalled, isTrue);
    });

    test('Deve retornar um erro e nao chamar o onSuccess', () async {
      bool onSuccessCalled = false;
      bool onFinallyCalled = false;
      bool onErrorCalled = false;
      Object? error;

      Command0.execute<String>(
        () => throw Exception('teste'),
        onSuccess: (r) => onSuccessCalled = true,
        onError: (e, s) {
          error = e;
          onErrorCalled = true;
        },
        onFinally: () => onFinallyCalled = true,
      );

      expect(onSuccessCalled, isFalse);
      expect(onErrorCalled, isTrue);
      expect(onFinallyCalled, isTrue);
      expect(error, isA<Exception>());
    });

    test('Quando retornar uma exception e o onError for nulo, deve parar a execucao', () async {
      // Arrange
      bool onSuccessCalled = false;
      bool onFinallyCalled = false;

      // Act & Assert
      await expectLater(
        Command0.execute<String>(
          () => throw Exception('teste'),
          onSuccess: (r) => onSuccessCalled = true,
          onFinally: () => onFinallyCalled = true,
        ),
        throwsA(isA<Exception>()),
      );
      expect(onSuccessCalled, isFalse);
      expect(onFinallyCalled, isTrue);
    });
  });
}

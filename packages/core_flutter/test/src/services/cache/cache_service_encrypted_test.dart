import 'package:core_flutter/core_flutter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CacheServiceEncrypted cacheService;
  late SharedPreferences sharedPreferences;
  const String encryptKey = 'test_encryption_key_123';

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    sharedPreferences = await SharedPreferences.getInstance();
    cacheService = CacheServiceEncrypted(
      sharedPreferences: sharedPreferences,
      encryptKey: encryptKey,
    );
  });

  group('CacheServiceEncrypted', () {
    test('deve salvar e recuperar dados corretamente', () async {
      // Arrange
      final data = {'test': 'value', 'number': 123};

      // Act
      await cacheService.save(box: 'testBox', data: data);
      final result = await cacheService.get(box: 'testBox');

      // Assert
      expect(result, isNotNull);
      expect(result!['test'], equals('value'));
      expect(result['number'], equals(123));
    });

    test('deve retornar null quando o box não existe', () async {
      // Act
      final result = await cacheService.get(box: 'nonexistentBox');

      // Assert
      expect(result, isNull);
    });

    test('deve excluir dados corretamente', () async {
      // Arrange
      final data = {'test': 'value'};
      await cacheService.save(box: 'testBox', data: data);

      // Act
      await cacheService.delete(box: 'testBox');
      final result = await cacheService.get(box: 'testBox');

      // Assert
      expect(result, isNull);
    });

    test('deve limpar todos os dados corretamente', () async {
      // Arrange
      final data1 = {'test1': 'value1'};
      final data2 = {'test2': 'value2'};
      await cacheService.save(box: 'testBox1', data: data1);
      await cacheService.save(box: 'testBox2', data: data2);

      // Act
      await cacheService.clear();
      final result1 = await cacheService.get(box: 'testBox1');
      final result2 = await cacheService.get(box: 'testBox2');

      // Assert
      expect(result1, isNull);
      expect(result2, isNull);
    });

    test('deve expirar dados corretamente', () async {
      // Arrange
      final data = {'test': 'value'};
      final expiresAt = DateTime.now().add(const Duration(seconds: 1));

      // Act
      await cacheService.save(
        box: 'testBox',
        data: data,
        expiresAt: expiresAt,
      );

      final resultBeforeExpiration = await cacheService.get(box: 'testBox');
      expect(resultBeforeExpiration, isNotNull);
      expect(resultBeforeExpiration!['test'], equals('value'));

      // Aguarda a expiração
      await Future.delayed(const Duration(seconds: 2));

      final resultAfterExpiration = await cacheService.get(box: 'testBox');
      expect(resultAfterExpiration, isNull);
    });

    test('deve manter dados sem data de expiração indefinidamente', () async {
      // Arrange
      final data = {'test': 'value'};

      // Act
      await cacheService.save(box: 'testBox', data: data);
      await Future.delayed(const Duration(seconds: 2));
      final result = await cacheService.get(box: 'testBox');

      // Assert
      expect(result, isNotNull);
      expect(result!['test'], equals('value'));
    });
  });
}

import 'package:resolver/resolver.dart';
import 'package:test/test.dart';

void main() {
  group('Resolver Pattern Tests', () {
    group('Criação de Resolvers', () {
      test('deve criar Resolver de sucesso', () {
        final result = Resolver.success('teste');

        expect(result.isSuccess, isTrue);
        expect(result.isFailure, isFalse);
        expect(result.valueOrNull, equals('teste'));
        expect(result.errorOrNull, isNull);
      });

      test('deve criar Resolver de falha', () {
        final result = Resolver.failure('erro');

        expect(result.isSuccess, isFalse);
        expect(result.isFailure, isTrue);
        expect(result.valueOrNull, isNull);
        expect(result.errorOrNull, equals('erro'));
      });

      test('deve criar Resolver com funções de conveniência', () {
        final successResult = success<String, String>('valor');
        final failureResult = failure<String, String>('erro');

        expect(successResult.isSuccess, isTrue);
        expect(failureResult.isFailure, isTrue);
      });
    });

    group('Result.fromFuture', () {
      test('deve capturar sucesso de Future', () async {
        final future = Future.value('sucesso');
        final result = await Result.fromFuture(future);

        expect(result.isSuccess, isTrue);
        expect(result.value, equals('sucesso'));
      });

      test('deve capturar falha de Future', () async {
        final future = Future<String>.error('erro original');
        final result = await Result.fromFuture(future, onError: (e) => 'erro capturado: $e');

        expect(result.isFailure, isTrue);
        expect(result.error.toString(), contains('erro capturado: erro original'));
      });
    });

    group('Result.from', () {
      test('deve capturar sucesso de operação síncrona', () {
        final result = Result.from(() => 42);

        expect(result.isSuccess, isTrue);
        expect(result.value, equals(42));
      });

      test('deve capturar falha de operação síncrona', () {
        final result = Result.from<int>(() => throw Exception('erro original'), onError: (e) => 'erro capturado: $e');

        expect(result.isFailure, isTrue);
        expect(result.error.toString(), contains('erro capturado'));
      });
    });

    group('Result Tests', () {
      test('deve criar Result de sucesso', () {
        final result = Result.success('teste');

        expect(result.isSuccess, isTrue);
        expect(result.value, equals('teste'));
      });

      test('deve criar Result de falha', () {
        final result = Result.failure(Exception('erro'));

        expect(result.isFailure, isTrue);
        expect(result.error.toString(), contains('erro'));
      });

      test('deve usar Result com sintaxe mais limpa', () {
        // Sintaxe tradicional
        Resolver<String, Exception> tradicional = Resolver.success('valor');

        // Sintaxe simplificada com Result
        final simples = Result.success('valor');

        expect(tradicional.value, equals(simples.value));
      });

      test('deve usar fromFuture', () async {
        final future = Future.value('sucesso');
        final result = await Result.fromFuture(future);

        expect(result.isSuccess, isTrue);
        expect(result.value, equals('sucesso'));
      });

      test('deve capturar erro com fromFuture', () async {
        final future = Future<String>.error('erro original');
        final result = await Result.fromFuture(future, onError: (e) => 'Erro customizado');

        expect(result.isFailure, isTrue);
        expect(result.error.toString(), contains('Erro customizado'));
      });

      test('deve usar from', () {
        final result = Result.from(() => 42);

        expect(result.isSuccess, isTrue);
        expect(result.value, equals(42));
      });

      test('deve capturar erro com from', () {
        final result = Result.from<int>(() => throw Exception('erro original'), onError: (e) => 'Erro customizado');

        expect(result.isFailure, isTrue);
        expect(result.error.toString(), contains('Erro customizado'));
      });
    });

    group('AsyncResult Tests', () {
      test('deve trabalhar com AsyncResult typedef', () async {
        AsyncResult<String> criarAsyncResult(bool sucesso) async {
          if (sucesso) {
            return Result.success('async sucesso');
          } else {
            return Result.failure(Exception('async erro'));
          }
        }

        final sucessoResult = await criarAsyncResult(true);
        expect(sucessoResult.isSuccess, isTrue);
        expect(sucessoResult.value, equals('async sucesso'));

        final falhaResult = await criarAsyncResult(false);
        expect(falhaResult.isFailure, isTrue);
        expect(falhaResult.error.toString(), contains('async erro'));
      });
    });

    group('AsyncResolver Tests', () {
      test('deve trabalhar com AsyncResolver typedef', () async {
        AsyncResolver<String, String> criarAsyncResolver(bool sucesso) async {
          if (sucesso) {
            return Resolver.success('async resolver sucesso');
          } else {
            return Resolver.failure('async resolver erro');
          }
        }

        final sucessoResult = await criarAsyncResolver(true);
        expect(sucessoResult.isSuccess, isTrue);
        expect(sucessoResult.value, equals('async resolver sucesso'));

        final falhaResult = await criarAsyncResolver(false);
        expect(falhaResult.isFailure, isTrue);
        expect(falhaResult.error, equals('async resolver erro'));
      });
    });

    group('Pattern Matching', () {
      test('when deve executar callback de sucesso', () {
        final result = Resolver.success(42);
        final output = result.when(onSuccess: (value) => 'sucesso: $value', onFailure: (error) => 'erro: $error');

        expect(output, equals('sucesso: 42'));
      });

      test('when deve executar callback de falha', () {
        final result = Resolver.failure('erro');
        final output = result.when(onSuccess: (value) => 'sucesso: $value', onFailure: (error) => 'erro: $error');

        expect(output, equals('erro: erro'));
      });

      test('whenVoid deve executar callback de sucesso', () {
        final result = Resolver.success(42);
        var executed = false;

        result.whenVoid(onSuccess: (value) => executed = true, onFailure: (error) => executed = false);

        expect(executed, isTrue);
      });

      test('whenVoid deve executar callback de falha', () {
        final result = Resolver.failure('erro');
        var executed = false;

        result.whenVoid(onSuccess: (value) => executed = false, onFailure: (error) => executed = true);

        expect(executed, isTrue);
      });
    });

    group('Transformações', () {
      test('map deve transformar valor de sucesso', () {
        final result = Resolver.success(42);
        final mapped = result.map((value) => value.toString());

        expect(mapped.isSuccess, isTrue);
        expect(mapped.value, equals('42'));
      });

      test('map não deve transformar valor de falha', () {
        final result = Resolver<int, String>.failure('erro');
        final mapped = result.map((value) => value.toString());

        expect(mapped.isFailure, isTrue);
        expect(mapped.error, equals('erro'));
      });

      test('mapError deve transformar erro de falha', () {
        final result = Resolver<int, String>.failure('erro');
        final mapped = result.mapError((error) => 'transformado: $error');

        expect(mapped.isFailure, isTrue);
        expect(mapped.error, equals('transformado: erro'));
      });

      test('mapError não deve transformar valor de sucesso', () {
        final result = Resolver<int, String>.success(42);
        final mapped = result.mapError((error) => 'transformado: $error');

        expect(mapped.isSuccess, isTrue);
        expect(mapped.value, equals(42));
      });
    });

    group('FlatMap', () {
      test('flatMap deve encadear operações de sucesso', () {
        final result = Resolver.success(42);
        final chained = result.flatMap((value) => Resolver.success(value * 2));

        expect(chained.isSuccess, isTrue);
        expect(chained.value, equals(84));
      });

      test('flatMap deve propagar falha', () {
        final result = Resolver<int, String>.failure('erro');
        final chained = result.flatMap((value) => Resolver.success(value * 2));

        expect(chained.isFailure, isTrue);
        expect(chained.error, equals('erro'));
      });

      test('flatMap deve retornar falha do mapper', () {
        final result = Resolver.success(42);
        final chained = result.flatMap<int>((value) => Resolver.failure('erro do mapper'));

        expect(chained.isFailure, isTrue);
        expect(chained.error, equals('erro do mapper'));
      });

      test('flatMapAsync deve funcionar com Future', () async {
        final result = Resolver.success(42);
        final chained = await result.flatMapAsync((value) async => Resolver.success(value * 2));

        expect(chained.isSuccess, isTrue);
        expect(chained.value, equals(84));
      });
    });

    group('Filter', () {
      test('filter deve manter valor que passa no predicado', () {
        final result = Resolver.success(42);
        final filtered = result.filter((value) => value > 0, () => 'valor deve ser positivo');

        expect(filtered.isSuccess, isTrue);
        expect(filtered.value, equals(42));
      });

      test('filter deve falhar quando predicado não passa', () {
        final result = Resolver.success(-42);
        final filtered = result.filter((value) => value > 0, () => 'valor deve ser positivo');

        expect(filtered.isFailure, isTrue);
        expect(filtered.error, equals('valor deve ser positivo'));
      });

      test('filter deve propagar falha', () {
        final result = Resolver<int, String>.failure('erro original');
        final filtered = result.filter((value) => value > 0, () => 'valor deve ser positivo');

        expect(filtered.isFailure, isTrue);
        expect(filtered.error, equals('erro original'));
      });
    });

    group('Utilitários', () {
      test('getOrElse deve retornar valor em caso de sucesso', () {
        final result = Resolver.success(42);
        final value = result.getOrElse(() => 0);

        expect(value, equals(42));
      });

      test('getOrElse deve retornar valor padrão em caso de falha', () {
        final result = Resolver<int, String>.failure('erro');
        final value = result.getOrElse(() => 0);

        expect(value, equals(0));
      });

      test('orElse deve retornar mesmo Resolver em caso de sucesso', () {
        final result = Resolver.success(42);
        final alternative = result.orElse(() => Resolver.success(0));

        expect(alternative.isSuccess, isTrue);
        expect(alternative.value, equals(42));
      });

      test('orElse deve retornar alternativa em caso de falha', () {
        final result = Resolver<int, String>.failure('erro');
        final alternative = result.orElse(() => Resolver.success(0));

        expect(alternative.isSuccess, isTrue);
        expect(alternative.value, equals(0));
      });
    });

    group('Zip', () {
      test('zip deve combinar dois sucessos', () {
        final result1 = Resolver.success(42);
        final result2 = Resolver.success('teste');
        final zipped = result1.zip(result2);

        expect(zipped.isSuccess, isTrue);
        expect(zipped.value.$1, equals(42));
        expect(zipped.value.$2, equals('teste'));
      });

      test('zip deve falhar se primeiro Resolver falha', () {
        final result1 = Resolver<int, String>.failure('erro1');
        final result2 = Resolver<String, String>.success('teste');
        final zipped = result1.zip(result2);

        expect(zipped.isFailure, isTrue);
        expect(zipped.error, equals('erro1'));
      });

      test('zip deve falhar se segundo Resolver falha', () {
        final result1 = Resolver.success(42);
        final result2 = Resolver<String, String>.failure('erro2');
        final zipped = result1.zip(result2);

        expect(zipped.isFailure, isTrue);
        expect(zipped.error, equals('erro2'));
      });
    });

    group('Side Effects', () {
      test('onSuccess deve executar callback apenas em sucesso', () {
        var executed = false;
        final result = Resolver.success(42);

        final returned = result.onSuccess((value) => executed = true);

        expect(executed, isTrue);
        expect(returned, equals(result));
      });

      test('onSuccess não deve executar callback em falha', () {
        var executed = false;
        final result = Resolver<int, String>.failure('erro');

        final returned = result.onSuccess((value) => executed = true);

        expect(executed, isFalse);
        expect(returned, equals(result));
      });

      test('onFailure deve executar callback apenas em falha', () {
        var executed = false;
        final result = Resolver<int, String>.failure('erro');

        final returned = result.onFailure((error) => executed = true);

        expect(executed, isTrue);
        expect(returned, equals(result));
      });

      test('onFailure não deve executar callback em sucesso', () {
        var executed = false;
        final result = Resolver.success(42);

        final returned = result.onFailure((error) => executed = true);

        expect(executed, isFalse);
        expect(returned, equals(result));
      });
    });

    group('Conversões', () {
      test('toFuture deve retornar Future com valor em sucesso', () async {
        final result = Resolver.success(42);
        final value = await result.toFuture();

        expect(value, equals(42));
      });

      test('toFuture deve lançar exceção em falha', () {
        final result = Resolver<int, String>.failure('erro');

        expect(() => result.toFuture(), throwsA(isA<ResultException>()));
      });
    });

    group('Igualdade e Hash', () {
      test('Resolvers de sucesso com mesmo valor devem ser iguais', () {
        final result1 = Resolver.success(42);
        final result2 = Resolver.success(42);

        expect(result1, equals(result2));
        expect(result1.hashCode, equals(result2.hashCode));
      });

      test('Resolvers de falha com mesmo erro devem ser iguais', () {
        final result1 = Resolver<int, String>.failure('erro');
        final result2 = Resolver<int, String>.failure('erro');

        expect(result1, equals(result2));
        expect(result1.hashCode, equals(result2.hashCode));
      });

      test('Resolvers diferentes não devem ser iguais', () {
        final result1 = Resolver.success(42);
        final result2 = Resolver<int, String>.failure('erro');

        expect(result1, isNot(equals(result2)));
      });
    });

    group('toString', () {
      test('Success deve ter toString correto', () {
        final result = Resolver.success(42);
        expect(result.toString(), equals('Success(42)'));
      });

      test('Failure deve ter toString correto', () {
        final result = Resolver.failure('erro');
        expect(result.toString(), equals('Failure(erro)'));
      });
    });

    group('Exemplo Prático PaipFood', () {
      test('deve simular validação de login com Result', () async {
        // Simula uma função de login que pode falhar
        Future<Resolver<String, Exception>> fazerLogin(String email, String senha) async {
          if (email.isEmpty) {
            return Result.failure(Exception('Email é obrigatório'));
          }
          if (senha.length < 6) {
            return Result.failure(Exception('Senha deve ter pelo menos 6 caracteres'));
          }

          // Simula chamada da API
          return await Result.fromFuture(Future.delayed(Duration(milliseconds: 100), () => 'token_123'), onError: (e) => 'Falha na autenticação');
        }

        // Teste de sucesso
        final sucessoResult = await fazerLogin('user@test.com', '123456');
        expect(sucessoResult.isSuccess, isTrue);
        expect(sucessoResult.value, equals('token_123'));

        // Teste de falha - email vazio
        final falhaEmail = await fazerLogin('', '123456');
        expect(falhaEmail.isFailure, isTrue);
        expect(falhaEmail.error.toString(), contains('Email é obrigatório'));

        // Teste de falha - senha curta
        final falhaSenha = await fazerLogin('user@test.com', '123');
        expect(falhaSenha.isFailure, isTrue);
        expect(falhaSenha.error.toString(), contains('pelo menos 6 caracteres'));
      });

      test('deve encadear operações com flatMap usando Result', () {
        // Simula validação e processamento de pedido
        Resolver<String, Exception> validarEmail(String email) {
          return email.contains('@') ? Result.success(email) : Result.failure(Exception('Email inválido'));
        }

        Resolver<String, Exception> processarPedido(String email) {
          return Result.success('Pedido processado para $email');
        }

        // Encadeamento de operações
        final resultado = validarEmail('user@test.com').flatMap<String>((email) => processarPedido(email));

        expect(resultado.isSuccess, isTrue);
        expect(resultado.value, equals('Pedido processado para user@test.com'));

        // Teste com email inválido
        final resultadoInvalido = validarEmail('email-invalido').flatMap((email) => processarPedido(email));

        expect(resultadoInvalido.isFailure, isTrue);
        expect(resultadoInvalido.error.toString(), contains('Email inválido'));
      });

      test('deve demonstrar AsyncResult em operações assíncronas', () async {
        AsyncResult<String> buscarDadosUsuario(int userId) async {
          if (userId <= 0) {
            return Result.failure(Exception('ID de usuário inválido'));
          }

          return await Result.fromFuture(Future.delayed(Duration(milliseconds: 50), () => 'Usuário $userId'), onError: (e) => 'Falha ao buscar dados do usuário');
        }

        final resultado = await buscarDadosUsuario(123);
        expect(resultado.isSuccess, isTrue);
        expect(resultado.value, equals('Usuário 123'));

        final resultadoInvalido = await buscarDadosUsuario(-1);
        expect(resultadoInvalido.isFailure, isTrue);
        expect(resultadoInvalido.error.toString(), contains('ID de usuário inválido'));
      });

      test('deve demonstrar AsyncResolver com tipos específicos', () async {
        AsyncResolver<Map<String, dynamic>, String> buscarConfiguracao(String chave) async {
          if (chave.isEmpty) {
            return Resolver.failure('Chave não pode estar vazia');
          }

          // Simulando uma operação que pode falhar
          try {
            final config = await Future.delayed(Duration(milliseconds: 30), () => {'config': chave, 'valor': 'teste'});
            return Resolver.success(config);
          } catch (e) {
            return Resolver.failure('Erro ao buscar configuração: $e');
          }
        }

        final resultado = await buscarConfiguracao('tema');
        expect(resultado.isSuccess, isTrue);
        expect(resultado.value['config'], equals('tema'));
        expect(resultado.value['valor'], equals('teste'));

        final resultadoInvalido = await buscarConfiguracao('');
        expect(resultadoInvalido.isFailure, isTrue);
        expect(resultadoInvalido.error, equals('Chave não pode estar vazia'));
      });
    });
  });

  group('ResultException Tests', () {
    test('deve criar exceção com mensagem', () {
      final exception = ResultException('mensagem de teste');

      expect(exception.message, equals('mensagem de teste'));
      expect(exception.toString(), equals('ResultException: mensagem de teste'));
    });
  });
}

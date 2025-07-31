# Testes Unitários - Módulo de Autenticação

Este diretório contém todos os testes unitários para o módulo de autenticação do PaipFood.

## Estrutura dos Testes

```
test/
├── auth_test.dart                                     # Arquivo principal de testes
├── src/
│   ├── memory/
│   │   └── auth_memory_test.dart                     # Testes da memória de autenticação
│   ├── events/
│   │   └── events_test.dart                          # Testes dos eventos de autenticação
│   ├── domain/
│   │   ├── models/
│   │   │   └── auth_model_test.dart                  # Testes do modelo de autenticação
│   │   ├── dtos/
│   │   │   └── refresh_token_dto_test.dart           # Testes do DTO de refresh token
│   │   └── usecases/
│   │       ├── get_refresh_token_cached_usecase_test.dart    # Testes do UC de obter token
│   │       ├── save_refresh_token_cached_usecase_test.dart   # Testes do UC de salvar token
│   │       ├── force_refresh_token_usecase_test.dart        # Testes do UC de forçar refresh
│   │       └── refresh_token_usecase_test.dart              # Testes do UC principal
└── README.md                                         # Esta documentação
```

## Cobertura de Testes

### 1. AuthMemory (`auth_memory_test.dart`)
- ✅ Padrão Singleton
- ✅ Estados de autenticação (login/logout)
- ✅ Atualização de usuário
- ✅ Observer pattern para mudanças de estado
- ✅ Tratamento de erros

### 2. Eventos (`events_test.dart`)
- ✅ RefreshTokenEvent
- ✅ AuthEventLoggedIn
- ✅ UserLoggedOutEvent
- ✅ UserUpdatedEvent
- ✅ Integridade de dados dos eventos

### 3. Modelos (`auth_model_test.dart`)
- ✅ Construção do modelo
- ✅ Método copyWith
- ✅ Serialização/Deserialização JSON
- ✅ Construção de PhoneNumber
- ✅ Casos extremos

### 4. DTOs (`refresh_token_dto_test.dart`)
- ✅ Construção com diferentes providers (phone/email)
- ✅ Detecção de provider
- ✅ Cálculo de expiração
- ✅ Serialização/Deserialização
- ✅ Factory methods
- ✅ Validação de JWT

### 5. Cases de Uso

#### GetRefreshTokenCachedUsecase (`get_refresh_token_cached_usecase_test.dart`)
- ✅ Recuperação bem-sucedida de token
- ✅ Tratamento de exceções (token não encontrado, expirado)
- ✅ Limpeza de tokens inválidos
- ✅ Validação de JWT secrets
- ✅ Casos extremos

#### SaveRefreshTokenCachedUsecase (`save_refresh_token_cached_usecase_test.dart`)
- ✅ Salvamento com diferentes providers
- ✅ Tratamento de tokens existentes
- ✅ Geração de JWT válidos
- ✅ Preservação de integridade de dados
- ✅ Casos extremos (expiração curta/longa)

#### ForceRefreshTokenUsecase (`force_refresh_token_usecase_test.dart`)
- ✅ Autenticação por telefone
- ✅ Autenticação por email
- ✅ Validação de provider
- ✅ Tratamento de erros de API
- ✅ Tratamento de diferentes encrypt keys

#### RefreshTokenUsecase (`refresh_token_usecase_test.dart`)
- ✅ Fluxo completo de refresh token
- ✅ Validação de device auth ID
- ✅ Tratamento de erros do fluxo principal
- ✅ Fluxo de fallback (force refresh)
- ✅ Integração com todos os componentes
- ✅ Chamadas concorrentes

## Tecnologias Utilizadas

- **flutter_test**: Framework de testes do Flutter
- **mocktail**: Biblioteca de mocks mais moderna que mockito
- **shared_preferences**: Para testes de persistência

## Como Executar os Testes

### Executar todos os testes
```bash
flutter test
```

### Executar teste específico
```bash
flutter test test/src/memory/auth_memory_test.dart
```

### Executar testes com cobertura
```bash
flutter test --coverage
```

### Executar testes em modo watch
```bash
flutter test --watch
```

## Padrões de Teste

### 1. Estrutura AAA (Arrange-Act-Assert)
```dart
test('should do something', () {
  // Arrange
  final input = 'test';
  
  // Act
  final result = service.doSomething(input);
  
  // Assert
  expect(result, equals('expected'));
});
```

### 2. Uso de Mocks
```dart
class MockService extends Mock implements Service {}

setUp(() {
  mockService = MockService();
  when(() => mockService.method()).thenReturn('result');
});
```

### 3. Grupos de Testes
```dart
group('Feature Tests', () {
  group('Success Cases', () {
    test('should succeed when...', () {});
  });
  
  group('Error Cases', () {
    test('should fail when...', () {});
  });
});
```

### 4. Testes de Integração
```dart
test('should integrate all components', () {
  // Testa a integração entre múltiplos componentes
});
```

## Melhores Práticas

1. **Nomenclatura Clara**: Use nomes descritivos para testes
2. **Isolamento**: Cada teste deve ser independente
3. **Setup/Teardown**: Use `setUp()` e `tearDown()` para preparar/limpar estado
4. **Mocks Específicos**: Use mocks apenas quando necessário
5. **Casos Extremos**: Teste edge cases e cenários de erro
6. **Cobertura**: Mantenha alta cobertura de testes
7. **Documentação**: Documente comportamentos complexos

## Comandos Úteis

```bash
# Executar testes com verbose output
flutter test --verbose

# Executar testes em dispositivo específico
flutter test -d <device_id>

# Executar testes com reporter personalizado
flutter test --reporter json

# Limpar cache antes dos testes
flutter clean && flutter test
```

## Configuração do Mocktail

O mocktail está configurado no `pubspec.yaml`:

```yaml
dev_dependencies:
  mocktail: ^1.0.4
```

### Exemplo de uso:
```dart
import 'package:mocktail/mocktail.dart';

class MockRepository extends Mock implements Repository {}

void main() {
  late MockRepository mockRepository;
  
  setUp(() {
    mockRepository = MockRepository();
  });
  
  test('should call repository method', () {
    // Arrange
    when(() => mockRepository.getData()).thenReturn('data');
    
    // Act
    final result = mockRepository.getData();
    
    // Assert
    expect(result, 'data');
    verify(() => mockRepository.getData()).called(1);
  });
}
```

## Contribuindo

Ao adicionar novos testes:

1. Siga a estrutura de diretórios existente
2. Use padrões de nomenclatura consistentes
3. Inclua testes para casos de sucesso e erro
4. Documente comportamentos complexos
5. Mantenha alta cobertura de testes
6. Execute todos os testes antes de fazer commit 
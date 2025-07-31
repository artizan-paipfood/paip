# Plano de Refatoração: Microfront-end com Event Bus

## 📋 Visão Geral

Este documento detalha o plano de refatoração da arquitetura atual para um sistema de microfront-ends baseado em Event Bus, seguindo princípios SOLID e permitindo reutilização entre Consumer App, Manager App e Portal.

## 🎯 Objetivos

- **Modularidade**: Separar responsabilidades em microfront-ends independentes
- **Reutilização**: Código compartilhado entre Consumer, Manager e Portal
- **Manutenibilidade**: Princípios SOLID aplicados consistentemente
- **Escalabilidade**: Facilitar adição de novas funcionalidades
- **Testabilidade**: Componentes isolados e testáveis

## 🏗️ Arquitetura Proposta

### Core Event Bus
```
packages/event_bus/
├── lib/
│   ├── event_bus.dart
│   ├── src/
│   │   ├── events/           # Definições de eventos
│   │   ├── handlers/         # Handlers base
│   │   └── types/           # Tipos e interfaces
│   └── event_bus_exports.dart
```

### Estrutura de Microfront-ends
```
features/
├── auth/                    # Autenticação
├── menu/                    # Cardápio e produtos
├── cart/                    # Carrinho de compras  
├── checkout/                # Finalização de pedidos
├── address/                 # Busca e gestão de endereços
├── delivery_tax/            # Cálculo de taxas
├── order_type/              # Tipo do pedido (delivery/balcão)
├── payments/                # Processamento de pagamentos
└── order_summary/           # Resumo da ordem
```

## 🔄 Microfront-ends Detalhados

### 1. Auth Microfront-end
**Responsabilidades:**
- Login/Logout
- Gerenciamento de tokens
- Validação de sessão
- Perfis de usuário

**Eventos Emitidos:**
- `UserLoggedIn`
- `UserLoggedOut`
- `TokenExpired`
- `UserProfileUpdated`

**Eventos Consumidos:**
- `RequireAuthentication`
- `RefreshToken`

### 2. Menu Microfront-end
**Responsabilidades:**
- Listagem de produtos
- Categorias
- Detalhes do produto
- Disponibilidade

**Eventos Emitidos:**
- `ProductSelected`
- `CategoryChanged`
- `MenuLoaded`

**Eventos Consumidos:**
- `LoadMenu`
- `FilterProducts`

### 3. Cart Microfront-end
**Responsabilidades:**
- Adicionar/remover produtos
- Gerenciar quantidades
- Calcular subtotais
- Validar estoque

**Eventos Emitidos:**
- `ProductAddedToCart`
- `ProductRemovedFromCart`
- `CartUpdated`
- `CartCleared`

**Eventos Consumidos:**
- `AddToCart`
- `RemoveFromCart`
- `ClearCart`

### 4. Checkout Microfront-end
**Responsabilidades:**
- Validações de pedido
- Aplicação de regras de negócio
- Coordenação da finalização
- Confirmação do pedido

**Eventos Emitidos:**
- `OrderValidated`
- `OrderCreated`
- `CheckoutStarted`
- `ValidationFailed`

**Eventos Consumidos:**
- `StartCheckout`
- `ValidateOrder`
- `CreateOrder`

### 5. Address Microfront-end
**Responsabilidades:**
- Busca de endereços
- Validação de CEP
- Cálculo de distância
- Área de entrega

**Eventos Emitidos:**
- `AddressSelected`
- `AddressValidated`
- `OutOfDeliveryArea`

**Eventos Consumidos:**
- `SearchAddress`
- `ValidateAddress`
- `CheckDeliveryArea`

### 6. Delivery Tax Microfront-end
**Responsabilidades:**
- Cálculo de taxa de entrega
- Validação de área
- Políticas de desconto
- Cache de taxas

**Eventos Emitidos:**
- `DeliveryTaxCalculated`
- `DeliveryTaxFailed`
- `TaxUpdated`

**Eventos Consumidos:**
- `CalculateDeliveryTax`
- `AddressChanged`
- `OrderTypeChanged`

### 7. Order Type Microfront-end
**Responsabilidades:**
- Seleção delivery/balcão
- Validação de tipo
- Regras específicas por tipo

**Eventos Emitidos:**
- `OrderTypeSelected`
- `OrderTypeChanged`
- `DeliveryRequired`

**Eventos Consumidos:**
- `SelectOrderType`
- `ValidateOrderType`

### 8. Payments Microfront-end
**Responsabilidades:**
- Métodos de pagamento
- Processamento
- Validações
- Status do pagamento

**Eventos Emitidos:**
- `PaymentMethodSelected`
- `PaymentProcessed`
- `PaymentFailed`

**Eventos Consumidos:**
- `ProcessPayment`
- `ValidatePayment`

### 9. Order Summary Microfront-end
**Responsabilidades:**
- Consolidação de dados
- Cálculos finais
- Apresentação do resumo
- Totalizações

**Eventos Emitidos:**
- `SummaryUpdated`
- `TotalsCalculated`

**Eventos Consumidos:**
- `CartUpdated`
- `DeliveryTaxCalculated`
- `PaymentMethodSelected`

## 📅 Plano de Migração (5 Fases)

### Fase 1: Foundation (1-2 semanas)
**Objetivo:** Criar base sólida para migração

**Tarefas:**
1. **Event Bus Core**
   ```dart
   // packages/event_bus/lib/src/event_bus_core.dart
   abstract class EventBus {
     void emit<T extends Event>(T event);
     StreamSubscription<T> on<T extends Event>(EventHandler<T> handler);
     void dispose();
   }
   ```

2. **Event Base Classes**
   ```dart
   // packages/event_bus/lib/src/events/base_event.dart
   abstract class Event {
     final DateTime timestamp;
     final String id;
     Event() : timestamp = DateTime.now(), id = Uuid().v4();
   }
   ```

3. **Core Models**
   ```dart
   // packages/core/lib/src/models/
   // Modelos compartilhados entre microfront-ends
   ```

**Entregáveis:**
- [ ] Package event_bus funcional
- [ ] Core models definidos
- [ ] Documentação de eventos
- [ ] Testes unitários do core

### Fase 2: Features Críticas (2-3 semanas)
**Objetivo:** Migrar funcionalidades que impactam o fluxo principal

**Order Type Microfront-end:**
```dart
// features/order_type/lib/src/order_type_service.dart
class OrderTypeService {
  void selectOrderType(OrderType type) {
    // Validações
    EventBus.instance.emit(OrderTypeSelected(type));
  }
}
```

**Delivery Tax Microfront-end:**
```dart
// features/delivery_tax/lib/src/delivery_tax_service.dart
class DeliveryTaxService {
  Future<void> calculateTax(Address address) async {
    try {
      final tax = await _repository.calculateTax(address);
      EventBus.instance.emit(DeliveryTaxCalculated(tax));
    } catch (e) {
      EventBus.instance.emit(DeliveryTaxFailed(e));
    }
  }
}
```

**Entregáveis:**
- [ ] Order Type microfront-end
- [ ] Delivery Tax microfront-end
- [ ] Address microfront-end
- [ ] Integração com apps existentes
- [ ] Testes de integração

### Fase 3: Features de Negócio (2-3 semanas)
**Objetivo:** Migrar lógica de negócio core

**Cart Microfront-end:**
```dart
// features/cart/lib/src/cart_service.dart
class CartService {
  void addProduct(Product product, int quantity) {
    _cart.addProduct(product, quantity);
    EventBus.instance.emit(ProductAddedToCart(product, quantity));
    EventBus.instance.emit(CartUpdated(_cart));
  }
}
```

**Menu Microfront-end:**
```dart
// features/menu/lib/src/menu_service.dart
class MenuService {
  Future<void> loadMenu() async {
    final menu = await _repository.getMenu();
    EventBus.instance.emit(MenuLoaded(menu));
  }
}
```

**Entregáveis:**
- [ ] Cart microfront-end
- [ ] Menu microfront-end
- [ ] Checkout microfront-end
- [ ] Validações de negócio
- [ ] Testes de fluxo completo

### Fase 4: Features Finais (1-2 semanas)
**Objetivo:** Completar ecossistema

**Auth Microfront-end:**
```dart
// features/auth/lib/src/auth_service.dart
class AuthService {
  Future<void> login(String email, String password) async {
    final user = await _repository.login(email, password);
    EventBus.instance.emit(UserLoggedIn(user));
  }
}
```

**Payments Microfront-end:**
```dart
// features/payments/lib/src/payment_service.dart
class PaymentService {
  Future<void> processPayment(PaymentData data) async {
    final result = await _gateway.process(data);
    EventBus.instance.emit(PaymentProcessed(result));
  }
}
```

**Entregáveis:**
- [ ] Auth microfront-end
- [ ] Payments microfront-end
- [ ] Order Summary microfront-end
- [ ] Documentação completa
- [ ] Testes E2E

### Fase 5: Views Específicas (1-2 semanas)
**Objetivo:** Adaptar interfaces para cada app

**Consumer App Views:**
```dart
// apps/app/lib/src/views/
// Interfaces otimizadas para consumidor
```

**Manager App Views:**
```dart
// apps/manager/lib/src/views/
// Interfaces para gestão
```

**Portal Views:**
```dart
// apps/portal/lib/src/views/ 
// Interfaces administrativas
```

**Entregáveis:**
- [ ] Views Consumer App
- [ ] Views Manager App  
- [ ] Views Portal
- [ ] Testes de UI
- [ ] Deploy e validação

## 🔧 Implementação Técnica

### Event Bus Implementation
```dart
// packages/event_bus/lib/src/event_bus_impl.dart
class EventBusImpl implements EventBus {
  final Map<Type, List<StreamController>> _controllers = {};
  
  @override
  void emit<T extends Event>(T event) {
    final controllers = _controllers[T];
    if (controllers != null) {
      for (final controller in controllers) {
        controller.add(event);
      }
    }
  }
  
  @override
  StreamSubscription<T> on<T extends Event>(EventHandler<T> handler) {
    _controllers.putIfAbsent(T, () => []);
    final controller = StreamController<T>.broadcast();
    _controllers[T]!.add(controller);
    
    return controller.stream.listen(handler);
  }
}
```

### Dependency Injection
```dart
// packages/core/lib/src/di/injector.dart
class MicroFrontendInjector {
  static void registerAuth() {
    GetIt.instance.registerSingleton<AuthService>(AuthService());
  }
  
  static void registerCart() {
    GetIt.instance.registerSingleton<CartService>(CartService());
  }
  
  // ... outros microfront-ends
}
```

### Feature Registration
```dart
// apps/app/lib/main.dart
void main() {
  // Registrar microfront-ends necessários
  MicroFrontendInjector.registerAuth();
  MicroFrontendInjector.registerCart();
  MicroFrontendInjector.registerMenu();
  // ...
  
  runApp(MyApp());
}
```

## 🧪 Estratégia de Testes

### Testes Unitários
```dart
// features/cart/test/cart_service_test.dart
group('CartService', () {
  test('should emit ProductAddedToCart when adding product', () {
    // Arrange
    final service = CartService();
    final product = Product(id: '1', name: 'Test');
    
    // Act & Assert
    expectLater(
      EventBus.instance.on<ProductAddedToCart>(),
      emits(isA<ProductAddedToCart>()),
    );
    
    service.addProduct(product, 1);
  });
});
```

### Testes de Integração
```dart
// test/integration/order_flow_test.dart
group('Order Flow Integration', () {
  testWidgets('complete order flow', (tester) async {
    // Setup microfront-ends
    // Simulate user interactions
    // Verify events are emitted correctly
    // Verify final state
  });
});
```

## 📊 Métricas de Sucesso

### Técnicas
- [ ] Cobertura de testes > 80%
- [ ] Tempo de build < 2 minutos
- [ ] Bundle size reduzido em 30%
- [ ] Acoplamento entre módulos < 10%

### Negócio
- [ ] Zero bugs críticos relacionados a taxa de entrega
- [ ] Tempo de desenvolvimento de novas features reduzido em 50%
- [ ] Reutilização de código entre apps > 70%
- [ ] Tempo de onboarding de novos devs reduzido em 40%

## 🚨 Riscos e Mitigações

### Risco: Complexidade de Comunicação
**Mitigação:** 
- Documentação clara de eventos
- Ferramentas de debug
- Monitoramento de performance

### Risco: Over-engineering
**Mitigação:**
- Migração gradual
- Validação constante
- Feedback loops

### Risco: Quebra de Funcionalidades
**Mitigação:**
- Testes automatizados
- Feature flags
- Rollback strategy

## 📚 Recursos Adicionais

### Documentação
- [ ] Guia de desenvolvimento
- [ ] Padrões de eventos
- [ ] Troubleshooting guide
- [ ] ADRs (Architecture Decision Records)

### Ferramentas
- [ ] Event debugger
- [ ] Performance monitor
- [ ] Dependency analyzer
- [ ] Code generator

## 🎉 Conclusão

Esta refatoração transformará a arquitetura atual em um sistema modular, reutilizável e mantível. O evento bus permitirá comunicação desacoplada entre microfront-ends, enquanto os princípios SOLID garantirão código limpo e extensível.

A migração gradual em 5 fases minimiza riscos e permite validação constante do progresso. O resultado final será uma arquitetura robusta que facilitará o desenvolvimento futuro e eliminará problemas como a taxa de entrega não sendo cobrada.

---

**Próximos Passos:**
1. Aprovação do plano pela equipe
2. Setup do ambiente de desenvolvimento
3. Início da Fase 1: Foundation
4. Acompanhamento semanal do progresso 
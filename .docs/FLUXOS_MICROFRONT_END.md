# Fluxos de Comunicação - Microfront-end Architecture

## 📋 Visão Geral

Este documento detalha os fluxos de comunicação entre os microfront-ends do PaipFood, incluindo diagramas de sequência, fluxos de eventos e padrões de interação via Event Bus.

## 🌊 Fluxos Principais

### 1. Fluxo de Pedido Completo (Consumer App)

```mermaid
sequenceDiagram
    participant U as User
    participant UI as UI Layer
    participant Auth as Auth MF
    participant Menu as Menu MF
    participant Cart as Cart MF
    participant Address as Address MF
    participant OrderType as OrderType MF
    participant DeliveryTax as DeliveryTax MF
    participant Checkout as Checkout MF
    participant Payment as Payment MF
    participant Summary as Summary MF
    participant EB as Event Bus

    U->>UI: Abrir app
    UI->>Auth: Verificar sessão
    Auth->>EB: UserSessionChecked
    
    U->>Menu: Navegar cardápio
    Menu->>EB: MenuLoaded
    
    U->>Cart: Adicionar produto
    Cart->>EB: ProductAddedToCart
    Cart->>EB: CartUpdated
    EB->>Summary: CartUpdated
    Summary->>EB: SummaryUpdated
    
    U->>Address: Selecionar endereço
    Address->>EB: AddressSelected
    Address->>EB: AddressValidated
    
    U->>OrderType: Escolher delivery
    OrderType->>EB: OrderTypeSelected
    EB->>DeliveryTax: OrderTypeSelected
    DeliveryTax->>EB: CalculateDeliveryTax
    DeliveryTax->>EB: DeliveryTaxCalculated
    EB->>Summary: DeliveryTaxCalculated
    Summary->>EB: SummaryUpdated
    
    U->>Checkout: Finalizar pedido
    Checkout->>EB: StartCheckout
    Checkout->>EB: ValidateOrder
    Checkout->>EB: OrderValidated
    
    U->>Payment: Processar pagamento
    Payment->>EB: ProcessPayment
    Payment->>EB: PaymentProcessed
    
    Summary->>EB: OrderCreated
```

### 2. Fluxo de Cálculo de Taxa de Entrega

```mermaid
flowchart TD
    A[Usuário Seleciona Endereço] --> B[Address MF]
    B --> C{Endereço Válido?}
    C -->|Não| D[AddressValidationFailed]
    C -->|Sim| E[AddressSelected]
    
    E --> F[Event Bus]
    F --> G[OrderType MF]
    G --> H{É Delivery?}
    H -->|Não| I[Sem Taxa]
    H -->|Sim| J[DeliveryTax MF]
    
    J --> K[Calcular Taxa]
    K --> L{Taxa Disponível?}
    L -->|Não| M[DeliveryTaxFailed]
    L -->|Sim| N[DeliveryTaxCalculated]
    
    N --> O[Summary MF]
    O --> P[Atualizar Total]
    P --> Q[SummaryUpdated]
    
    M --> R[Mostrar Erro]
    R --> S[Tentar Novamente]
    S --> J
```

### 3. Fluxo de Autenticação

```mermaid
sequenceDiagram
    participant U as User
    participant UI as Login UI
    participant Auth as Auth MF
    participant Menu as Menu MF
    participant Cart as Cart MF
    participant EB as Event Bus

    U->>UI: Email + Senha
    UI->>Auth: login(email, password)
    Auth->>Auth: Validar credenciais
    
    alt Login bem-sucedido
        Auth->>EB: UserLoggedIn
        EB->>Menu: UserLoggedIn
        Menu->>Menu: Carregar menu personalizado
        EB->>Cart: UserLoggedIn
        Cart->>Cart: Restaurar carrinho do usuário
        Auth->>UI: Navegar para home
    else Login falhou
        Auth->>EB: LoginFailed
        Auth->>UI: Mostrar erro
    end
    
    Note over Auth: Token expira
    Auth->>EB: TokenExpired
    EB->>UI: Redirecionar para login
```

### 4. Fluxo de Carrinho de Compras

```mermaid
flowchart LR
    A[Menu MF] --> B[ProductSelected]
    B --> C[Event Bus]
    C --> D[Cart MF]
    
    D --> E{Produto Existe no Carrinho?}
    E -->|Sim| F[Atualizar Quantidade]
    E -->|Não| G[Adicionar Produto]
    
    F --> H[ProductUpdatedInCart]
    G --> I[ProductAddedToCart]
    
    H --> J[Event Bus]
    I --> J
    J --> K[CartUpdated]
    K --> L[Summary MF]
    L --> M[Recalcular Totais]
    M --> N[SummaryUpdated]
    
    subgraph "Validações"
        O[Estoque Disponível?]
        P[Preço Válido?]
        Q[Produto Ativo?]
    end
    
    D --> O
    O --> P
    P --> Q
    Q --> E
```

### 5. Fluxo de Checkout

```mermaid
sequenceDiagram
    participant U as User
    participant UI as Checkout UI
    participant Checkout as Checkout MF
    participant Cart as Cart MF
    participant Address as Address MF
    participant OrderType as OrderType MF
    participant DeliveryTax as DeliveryTax MF
    participant Payment as Payment MF
    participant EB as Event Bus

    U->>UI: Iniciar checkout
    UI->>Checkout: StartCheckout
    
    Checkout->>EB: ValidateOrder
    EB->>Cart: ValidateOrder
    Cart->>EB: CartValidated/CartValidationFailed
    
    EB->>Address: ValidateOrder
    Address->>EB: AddressValidated/AddressValidationFailed
    
    EB->>OrderType: ValidateOrder
    OrderType->>EB: OrderTypeValidated/OrderTypeValidationFailed
    
    alt Delivery
        EB->>DeliveryTax: ValidateOrder
        DeliveryTax->>EB: DeliveryTaxValidated/DeliveryTaxValidationFailed
    end
    
    Checkout->>Checkout: Consolidar validações
    
    alt Todas validações OK
        Checkout->>EB: OrderValidated
        EB->>Payment: OrderValidated
        Payment->>UI: Mostrar métodos de pagamento
    else Alguma validação falhou
        Checkout->>EB: ValidationFailed
        Checkout->>UI: Mostrar erros
    end
```

## 🔄 Padrões de Comunicação

### Event-Driven Architecture

```mermaid
graph TB
    subgraph "Microfront-ends"
        A[Auth MF]
        B[Menu MF]
        C[Cart MF]
        D[Address MF]
        E[OrderType MF]
        F[DeliveryTax MF]
        G[Checkout MF]
        H[Payment MF]
        I[Summary MF]
    end
    
    subgraph "Event Bus"
        J[Event Publisher]
        K[Event Subscriber]
        L[Event Router]
    end
    
    A --> J
    B --> J
    C --> J
    D --> J
    E --> J
    F --> J
    G --> J
    H --> J
    I --> J
    
    K --> A
    K --> B
    K --> C
    K --> D
    K --> E
    K --> F
    K --> G
    K --> H
    K --> I
    
    J --> L
    L --> K
```

### Command Query Responsibility Segregation (CQRS)

```mermaid
flowchart LR
    subgraph "Commands (Write)"
        A[AddToCart]
        B[SelectAddress]
        C[ChooseOrderType]
        D[ProcessPayment]
    end
    
    subgraph "Event Bus"
        E[Command Handler]
        F[Event Publisher]
    end
    
    subgraph "Queries (Read)"
        G[GetCartItems]
        H[GetDeliveryTax]
        I[GetOrderSummary]
    end
    
    A --> E
    B --> E
    C --> E
    D --> E
    
    E --> F
    F --> G
    F --> H
    F --> I
```

## 📱 Fluxos por Aplicação

### Consumer App Flow

```mermaid
journey
    title Jornada do Cliente - Consumer App
    section Autenticação
      Login          : 5: Auth MF
      Verificar Sessão: 3: Auth MF
    section Navegação
      Ver Cardápio   : 5: Menu MF
      Filtrar Produtos: 4: Menu MF
      Ver Detalhes   : 4: Menu MF
    section Compra
      Adicionar ao Carrinho: 5: Cart MF
      Ver Carrinho   : 4: Cart MF
      Modificar Itens: 3: Cart MF
    section Endereço
      Buscar CEP     : 4: Address MF
      Selecionar Endereço: 5: Address MF
      Validar Área   : 3: Address MF
    section Finalização
      Escolher Delivery: 5: OrderType MF
      Ver Taxa       : 4: DeliveryTax MF
      Revisar Pedido : 5: Summary MF
      Pagar          : 5: Payment MF
      Confirmar      : 5: Checkout MF
```

### Manager App Flow

```mermaid
journey
    title Jornada do Gestor - Manager App
    section Autenticação
      Login Admin    : 5: Auth MF
      Verificar Permissões: 4: Auth MF
    section Gestão
      Ver Pedidos    : 5: Order Management MF
      Gerenciar Menu : 4: Menu MF
      Configurar Taxas: 3: DeliveryTax MF
    section Relatórios
      Dashboard      : 5: Analytics MF
      Vendas         : 4: Reports MF
      Financeiro     : 4: Financial MF
```

### Portal Flow

```mermaid
journey
    title Jornada Admin - Portal
    section Sistema
      Configurações  : 5: System Config MF
      Usuários       : 4: User Management MF
      Integrações    : 3: Integration MF
    section Analytics
      Métricas       : 5: Analytics MF
      Logs           : 3: Logging MF
      Performance    : 4: Monitoring MF
```

## 🎯 Event Mapping

### Eventos por Microfront-end

| Microfront-end | Eventos Emitidos | Eventos Consumidos |
|----------------|------------------|-------------------|
| **Auth** | `UserLoggedIn`, `UserLoggedOut`, `TokenExpired` | `RequireAuthentication`, `RefreshToken` |
| **Menu** | `ProductSelected`, `MenuLoaded`, `CategoryChanged` | `LoadMenu`, `FilterProducts`, `UserLoggedIn` |
| **Cart** | `ProductAddedToCart`, `CartUpdated`, `CartCleared` | `AddToCart`, `RemoveFromCart`, `UserLoggedIn` |
| **Address** | `AddressSelected`, `AddressValidated`, `OutOfDeliveryArea` | `SearchAddress`, `ValidateAddress` |
| **OrderType** | `OrderTypeSelected`, `DeliveryRequired` | `SelectOrderType`, `ValidateOrderType` |
| **DeliveryTax** | `DeliveryTaxCalculated`, `DeliveryTaxFailed` | `CalculateDeliveryTax`, `AddressSelected`, `OrderTypeSelected` |
| **Checkout** | `OrderValidated`, `OrderCreated`, `ValidationFailed` | `StartCheckout`, `ValidateOrder` |
| **Payment** | `PaymentProcessed`, `PaymentFailed`, `PaymentMethodSelected` | `ProcessPayment`, `ValidatePayment` |
| **Summary** | `SummaryUpdated`, `TotalsCalculated` | `CartUpdated`, `DeliveryTaxCalculated`, `PaymentMethodSelected` |

### Event Flow Matrix

```mermaid
graph LR
    subgraph "Event Producers"
        A[User Actions]
        B[System Events]
        C[External APIs]
    end
    
    subgraph "Event Bus"
        D[Event Router]
        E[Event Logger]
        F[Event Validator]
    end
    
    subgraph "Event Consumers"
        G[UI Updates]
        H[State Changes]
        I[Side Effects]
    end
    
    A --> D
    B --> D
    C --> D
    
    D --> E
    D --> F
    
    D --> G
    D --> H
    D --> I
```

## 🚦 Tratamento de Erros

### Error Propagation Flow

```mermaid
sequenceDiagram
    participant MF as Microfront-end
    participant EB as Event Bus
    participant EH as Error Handler
    participant UI as UI Layer
    participant Log as Logger

    MF->>MF: Erro ocorre
    MF->>EB: ErrorOccurred event
    EB->>EH: Route error
    EH->>EH: Categorizar erro
    
    alt Erro crítico
        EH->>UI: ShowCriticalError
        EH->>Log: LogCriticalError
        UI->>UI: Bloquear ação
    else Erro recuperável
        EH->>UI: ShowWarning
        EH->>Log: LogWarning
        EH->>MF: TryRecover
    else Erro silencioso
        EH->>Log: LogInfo
    end
```

## 🔧 Debug e Monitoramento

### Event Flow Monitoring

```mermaid
flowchart TD
    A[Event Emitted] --> B{Debug Mode?}
    B -->|Yes| C[Log to Console]
    B -->|No| D[Production Logger]
    
    C --> E[Event Timeline]
    D --> F[Analytics Service]
    
    E --> G[Developer Tools]
    F --> H[Monitoring Dashboard]
    
    G --> I[Real-time Debugging]
    H --> J[Performance Metrics]
    
    subgraph "Debug Tools"
        K[Event Inspector]
        L[State Viewer]
        M[Flow Tracer]
    end
    
    I --> K
    I --> L
    I --> M
```

## 📊 Performance Considerations

### Event Bus Performance

```mermaid
graph TB
    A[Event Volume] --> B{High Volume?}
    B -->|Yes| C[Event Batching]
    B -->|No| D[Direct Processing]
    
    C --> E[Batch Processor]
    E --> F[Bulk Operations]
    
    D --> G[Immediate Processing]
    
    subgraph "Optimization Strategies"
        H[Event Debouncing]
        I[Subscription Pooling]
        J[Memory Management]
    end
    
    F --> H
    G --> I
    G --> J
```

## 🔄 State Synchronization

### Cross-App State Sync

```mermaid
sequenceDiagram
    participant CA as Consumer App
    participant MA as Manager App
    participant P as Portal
    participant SS as Shared State Service
    participant EB as Event Bus

    CA->>EB: StateChanged
    EB->>SS: UpdateSharedState
    SS->>SS: Validate change
    SS->>EB: SharedStateUpdated
    
    EB->>MA: SharedStateUpdated
    EB->>P: SharedStateUpdated
    
    MA->>MA: Update local UI
    P->>P: Update local UI
```

## 🎉 Conclusão

Os fluxos de comunicação entre microfront-ends seguem um padrão consistente baseado em eventos, garantindo baixo acoplamento e alta coesão. O Event Bus atua como o centralizador de comunicação, permitindo que cada microfront-end funcione independentemente while mantendo sincronização quando necessário.

### Benefícios dos Fluxos:
- **Desacoplamento**: Microfront-ends não conhecem uns aos outros diretamente
- **Escalabilidade**: Fácil adição de novos microfront-ends
- **Testabilidade**: Fluxos isolados são mais fáceis de testar
- **Debugging**: Event flow é rastreável e debugável
- **Reutilização**: Mesmos eventos funcionam em diferentes apps

### Próximos Passos:
1. Implementar Event Bus core
2. Definir contratos de eventos
3. Criar ferramentas de debug
4. Implementar monitoramento
5. Validar fluxos em ambiente de teste 
## 🏗️ Estrutura do Projeto

```
delivery_architecture/
├── melos.yaml                     # Configuração do Melos
├── apps/                          # Aplicações individuais (Micro-Frontend Ready)
│   ├── gestor_app/               # 📱 App do Gestor
│   │   ├── lib/
│   │   │   ├── modules/          # Flutter Modular modules
│   │   │   └── features/         # Features prontas para micro-frontend
│   │   │       ├── auth/         # 🔐 Autenticação
│   │   │       ├── menu/         # 🍕 Gerenciamento de Cardápio
│   │   │       ├── orders/       # 📋 Gestão de Pedidos
│   │   │       ├── analytics/    # 📊 Relatórios e Analytics
│   │   │       └── checkout/     # 💳 Processamento de Pagamentos
│   ├── portal_app/               # 🌐 Portal Web/Desktop
│   │   ├── lib/
│   │   │   ├── modules/          # Flutter Modular modules
│   │   │   └── features/         # Features compartilhadas + específicas
│   │   │       ├── auth/         # 🔐 Autenticação (compartilhada)
│   │   │       ├── dashboard/    # 📊 Dashboard Principal
│   │   │       ├── reports/      # 📈 Relatórios Avançados
│   │   │       └── settings/     # ⚙️ Configurações do Sistema
│   ├── entregador_app/           # 🛵 App dos Entregadores
│   │   ├── lib/
│   │   │   ├── modules/          # Flutter Modular modules
│   │   │   └── features/         # Features específicas do entregador
│   │   │       ├── auth/         # 🔐 Autenticação (compartilhada)
│   │   │       ├── deliveries/   # 🚚 Gestão de Entregas
│   │   │       ├── navigation/   # 🗺️ Navegação e Mapas
│   │   │       └── earnings/     # 💰 Controle de Ganhos
│   ├── delivery_app/             # 🍕 App dos Clientes
│   │   ├── lib/
│   │   │   ├── modules/          # Flutter Modular modules
│   │   │   └── features/         # Features do cliente
│   │   │       ├── auth/         # 🔐 Autenticação (compartilhada)
│   │   │       ├── menu/         # 🍕 Visualização do Cardápio
│   │   │       ├── cart/         # 🛒 Carrinho de Compras
│   │   │       ├── checkout/     # 💳 Finalização do Pedido
│   │   │       └── orders/       # 📱 Acompanhamento de Pedidos
│   └── admin_web/                # ⚙️ Dashboard Admin
│       ├── lib/
│       │   ├── modules/          # Flutter Modular modules
│       │   └── features/         # Features administrativas
│           ├── auth/             # 🔐 Autenticação (compartilhada)
│           ├── users/            # 👥 Gestão de Usuários
│           ├── establishments/   # 🏪 Gestão de Estabelecimentos
│           ├── system/           # ⚙️ Configurações do Sistema
│           └── monitoring/       # 📊 Monitoramento e Logs
├── backend/                      # Backend Services
│   ├── api/                      # 🔌 API Principal (Dart Frog)
│   ├── auth_service/             # 🔐 Serviço de Autenticação
│   └── notification_service/     # 📧 Serviço de Notificações
├── packages/                     # 📦 Pacotes Compartilhados
│   ├── core/                     # ⚡ Núcleo do Sistema
│   │   ├── lib/entities/         # 🎯 Entidades de Domínio
│   │   ├── lib/repositories/     # 🗄️ Interfaces de Repositórios
│   │   ├── lib/use_cases/        # 💼 Casos de Uso
│   │   ├── lib/exceptions/       # ⚠️ Exceções Customizadas
│   │   └── lib/constants/        # 📌 Constantes Globais
│   ├── shared_ui/               # 🎨 Componentes UI Compartilhados
│   │   ├── lib/components/         # 🧩 Widgets Reutilizáveis
│   │   ├── lib/themes/          # 🎨 Temas e Cores
│   │   ├── lib/extensions/      # 🔧 Extensions Úteis
│   │   └── lib/constants/       # 📐 Constantes Visuais
│   ├── network/                 # 🌐 Cliente HTTP Compartilhado
│   │   ├── lib/http_client/     # 📡 Cliente HTTP
│   │   ├── lib/interceptors/    # 🔄 Interceptadores
│   │   └── lib/models/          # 📋 DTOs de Rede
│   ├── storage/                 # 💾 Persistência Local
│   │   ├── lib/local_storage/   # 📱 Storage Local
│   │   ├── lib/cache/           # ⚡ Sistema de Cache
│   │   └── lib/secure_storage/  # 🔒 Storage Seguro
│   ├── validators/              # ✅ Validadores Compartilhados
│   │   ├── lib/form_validators/ # 📝 Validadores de Formulário
│   │   ├── lib/business_rules/  # 📊 Regras de Negócio
│   │   └── lib/utils/           # 🛠️ Utilitários de Validação
│   ├── utils/                   # 🔧 Utilitários Gerais
│   │   ├── lib/formatters/      # 📝 Formatadores
│   │   ├── lib/helpers/         # 🤝 Helpers Diversos
│   │   └── lib/extensions/      # ⚡ Extensions Úteis
│   └── testing/                 # 🧪 Helpers para Testes
│       ├── lib/mocks/           # 🎭 Mocks para Testes
│       ├── lib/fixtures/        # 📋 Dados de Teste
│       └── lib/helpers/         # 🛠️ Helpers de Teste
├── tools/                       # 🛠️ Scripts e Ferramentas
│   ├── scripts/                 # 📜 Scripts de Automação
│   └── generators/              # 🏗️ Geradores de Código
└── docs/                        # 📚 Documentação
    ├── architecture/            # 🏛️ Documentação de Arquitetura
    ├── api/                     # 📖 Documentação da API
    └── deployment/              # 🚀 Guias de Deploy

---

## 🧩 Estrutura de Feature (Micro-Frontend Ready)

### 💡 Conceito
Cada feature dentro dos apps é **autocontida** e pode ser extraída para um **micro-frontend** independente no futuro. Todas seguem a mesma estrutura simples e robusta.

### 📁 Estrutura Padrão de Feature
```
apps/[app_name]/lib/features/[feature_name]/
├── viewmodels/                    # Estado + Lógica (ChangeNotifier)
│   ├── [feature]_viewmodel.dart
│   └── [sub_feature]_viewmodel.dart
├── controllers/                   # Estado UI simples (ValueNotifier)
│   ├── form_controller.dart
│   └── stepper_controller.dart
├── pages/                         # Telas
│   ├── [feature]_page.dart
│   └── [sub_feature]_page.dart
├── components/                       # Componentes (widgets) reutilizáveis 
│   ├── forms/
│   ├── cards/
│   └── common/
├── models/                        # DTOs e Models específicos da UI
│   ├── [feature]_model.dart
│   └── [feature]_dto.dart
├── usecases/                      # Casos de uso específicos da feature
│   ├── [action]_usecase.dart
│   └── [validation]_usecase.dart
├── services/                      # Lógica de negócio específica
│   ├── [feature]_service.dart
│   └── api_service.dart
└── [feature]_module.dart          # Flutter Modular config
```

### 🔄 Compartilhamento de Features
- **Features comuns** (ex: `auth/`) são **reutilizadas** entre apps
- **Features específicas** ficam isoladas em cada app
- **Core packages** fornecem **entidades de domínio** compartilhadas
- **Features** usam **models/DTOs** para dados específicos da UI
- **Shared UI** fornece componentes visuais

### 🚀 Transformação em Micro-Frontend
Para extrair uma feature como micro-frontend:
1. **Mover** a pasta `features/[feature_name]/` para um novo projeto
2. **Adicionar** dependências do `core/` e `shared_ui/`  
3. **Configurar** Flutter Modular como app independente
4. **Deploy** como aplicação separada

### 🔍 Camadas e Responsabilidades
- **📦 Entidades** (`packages/core/`): Regras de negócio puras, imutáveis, compartilhadas
  ```dart
  // packages/core/lib/entities/product.dart
  class Product {
    final String id;
    final String name;
    final double price;
    // + regras de negócio puras
  }
  ```

- **⚡ Use Cases** (`features/*/usecases/`): Orquestram lógica de negócio específica
  ```dart
  // apps/gestor_app/lib/features/menu/usecases/create_product_usecase.dart
  class CreateProductUseCase {
    Future<Product> call(CreateProductParams params) async {
      // 1. Validar dados
      // 2. Chamar repository
      // 3. Retornar entidade
    }
  }
  ```

- **📱 Models/DTOs** (`features/*/models/`): Específicos da UI, manipulam entidades + estado local
  ```dart
  // apps/gestor_app/lib/features/menu/models/product_form_model.dart
  class ProductFormModel {
    Product? product;           // Entidade do core
    Category? category;         // Outra entidade do core
    String? tempName;           // Estado temporário do form
    String? tempPrice;          // Estado temporário do form
    bool isEditing;             // Estado da UI
    bool hasErrors;             // Estado da UI
    
    // Métodos para manipular as entidades
    void updateFromProduct(Product product) { ... }
    Product toProduct() { ... }
  }
  ```

- **🔧 Services** (`features/*/services/`): Implementações concretas (API, cache, etc)
  ```dart
  // apps/gestor_app/lib/features/menu/services/menu_service.dart
  class MenuService {
    Future<List<Product>> getProducts() async {
      // Chamada API específica
    }
  }
  ```

### 📝 **Exemplos de Models com Múltiplas Entidades**

```dart
// Checkout com várias entidades
class CheckoutModel {
  Cart? cart;                    // Entidade carrinho
  User? user;                    // Entidade usuário  
  Address? deliveryAddress;      // Entidade endereço
  PaymentMethod? paymentMethod;  // Entidade pagamento
  
  // Estado da UI
  int currentStep;
  bool isProcessing;
  String? errorMessage;
  
  // Métodos de manipulação
  double get totalWithDelivery => cart?.total + deliveryAddress?.fee ?? 0;
  bool get canProceed => cart?.hasItems == true && user != null;
}

// Lista com filtros
class ProductListModel {
  List<Product> allProducts;     // Entidades produtos
  List<Category> categories;     // Entidades categorias
  
  // Estado de filtros da UI
  String searchQuery;
  Category? selectedCategory;
  bool showOnlyActive;
  
  // Computed properties
  List<Product> get filteredProducts => 
    allProducts.where((p) => matchesFilters(p)).toList();
}
```

### ✅ Benefícios
- ✅ **Desenvolvimento isolado** por feature
- ✅ **Times paralelos** trabalhando em features diferentes
- ✅ **Deploy independente** de funcionalidades
- ✅ **Reutilização máxima** entre apps
- ✅ **Separação clara** entre domínio e UI
- ✅ **Manutenção simplificada** com escopo bem definido
- ✅ **Testabilidade** isolada por feature
```
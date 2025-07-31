# Artizan CLI

CLI para geração de features e componentes no projeto PaipFood, seguindo a arquitetura estabelecida.

## Instalação

### Instalação Local (Desenvolvimento)

```bash
# No diretório raiz do projeto
dart pub get
```

### Instalação Global (Recomendado)

Para usar a CLI de qualquer lugar do sistema:

```bash
# Navegar para o diretório da CLI
cd packages/artizan_cli

# Executar o script de instalação
./install.sh
```

Ou manualmente:

```bash
# Ativar globalmente
dart pub global activate --source path packages/artizan_cli

# Adicionar ao PATH (adicione ao ~/.zshrc ou ~/.bashrc)
export PATH="$PATH:$(dart pub global bin)"
```

Após a instalação global, você pode usar o comando `artizan` de qualquer lugar:

```bash
# Verificar se está funcionando
artizan --help

# Criar uma feature
artizan feature auth
```

## Uso

### Comandos Disponíveis

```bash
# Mostrar ajuda
artizan help

# Mostrar versão
artizan version

# Criar uma nova feature
artizan feature <nome_da_feature>
```

### Exemplos

```bash
# Criar feature de autenticação
artizan feature auth

# Criar feature de perfil do usuário
artizan feature user_profile

# Criar feature de pedidos
artizan feature orders
```

## Estrutura Gerada

Quando você cria uma feature, a CLI gera automaticamente a seguinte estrutura completa:

```
features/<nome_feature>/
├── lib/
│   ├── main.dart                    # Arquivo principal da feature
│   ├── <nome_feature>.dart          # Arquivo de export principal
│   ├── i18n/                        # Internacionalização
│   │   ├── pt_BR.i18n.json          # Traduções em português
│   │   ├── en_US.i18n.json          # Traduções em inglês
│   │   └── gen/                     # Arquivos gerados pelo slang
│   └── src/
│       ├── <nome_feature>_module.dart # Módulo da feature
│       ├── data/
│       │   └── repositories/
│       │       └── <nome_feature>_repository.dart
│       ├── domain/
│       │   ├── models/
│       │   │   ├── <nome_feature>_model.dart
│       │   │   └── enums/
│       │   │       └── <nome_feature>_enums.dart
│       │   └── usecases/
│       │       └── <nome_feature>_usecase.dart
│       ├── presentation/
│       │   ├── pages/
│       │   │   └── <nome_feature>_page.dart
│       │   ├── components/
│       │   │   └── <nome_feature>_component.dart
│       │   └── viewmodels/
│       │       └── <nome_feature>_viewmodel.dart
│       ├── services/
│       │   └── <nome_feature>_service.dart
│       └── events/
│           └── <nome_feature>_event.dart
├── test/                            # Testes da feature
├── assets/                          # Assets da feature
├── pubspec.yaml                     # Dependências da feature
├── build.yaml                       # Configuração do build runner
└── analysis_options.yaml            # Regras de análise de código
```

## Arquivos Gerados

### pubspec.yaml
- Configurado com dependências padrão do projeto
- Inclui referências para `core`, `ui`, `i18n` e `artizan_ui`
- Inclui dependências para i18n (`slang`, `slang_flutter`, `intl`)
- Configurado para não ser publicado

### build.yaml
- Configuração do slang build runner para i18n
- Configurado para gerar arquivos de tradução automaticamente
- Suporte para português e inglês

### analysis_options.yaml
- Regras de linting seguindo os padrões do projeto
- Configurações de análise de código

### main.dart
- Aplicação Flutter básica da feature
- Estrutura inicial com MaterialApp
- Página inicial da feature

### <nome_feature>_module.dart
- Módulo da feature seguindo o padrão de injeção de dependência
- Preparado para adicionar binds conforme necessário

### <nome_feature>.dart
- Arquivo de export principal da feature
- Exporta o módulo e componentes principais

### Estrutura i18n
- **pt_BR.i18n.json**: Traduções em português brasileiro
- **en_US.i18n.json**: Traduções em inglês americano
- **gen/**: Diretório para arquivos gerados pelo slang

### Arquivos em Branco
Todos os arquivos são criados com comentários TODO para facilitar o desenvolvimento:
- `data/repositories/<nome_feature>_repository.dart`
- `domain/models/<nome_feature>_model.dart`
- `domain/models/enums/<nome_feature>_enums.dart`
- `domain/usecases/<nome_feature>_usecase.dart`
- `presentation/pages/<nome_feature>_page.dart`
- `presentation/components/<nome_feature>_component.dart`
- `presentation/viewmodels/<nome_feature>_viewmodel.dart`
- `services/<nome_feature>_service.dart`
- `events/<nome_feature>_event.dart`

## Próximos Passos

Após criar uma feature:

1. **Navegar para o diretório da feature:**
   ```bash
   cd features/<nome_feature>
   ```

2. **A CLI executa automaticamente:**
   - ✅ `flutter pub get` - Instala as dependências
   - ✅ `dart run slang` - Gera os arquivos de tradução

3. **Implementar a feature:**
   - Adicionar entidades no diretório `domain/models/`
   - Implementar repositories no diretório `data/repositories/`
   - Criar usecases no diretório `domain/usecases/`
   - Desenvolver widgets no diretório `presentation/`
   - Adicionar serviços no diretório `services/`
   - Implementar eventos no diretório `events/`
   - Adicionar traduções nos arquivos `i18n/*.i18n.json`

4. **Executar testes:**
   ```bash
   flutter test
   ```

## Arquitetura

A CLI segue a arquitetura Clean Architecture estabelecida no projeto:

- **Domain**: Entidades, enums e regras de negócio
- **Data**: Implementação de repositories e datasources
- **Presentation**: Interface do usuário, widgets e viewmodels
- **Services**: Serviços específicos da feature
- **Events**: Eventos e handlers da feature
- **i18n**: Internacionalização com slang

## Funcionalidades da CLI

### ✅ Implementadas
- ✅ Geração de estrutura completa de features
- ✅ Criação de arquivos de configuração (pubspec.yaml, build.yaml, analysis_options.yaml)
- ✅ Estrutura de pastas seguindo Clean Architecture
- ✅ Arquivos em branco com comentários TODO
- ✅ Configuração de i18n com slang
- ✅ Arquivos de tradução em português e inglês
- ✅ Módulo de injeção de dependência
- ✅ Aplicação Flutter básica
- ✅ Execução automática de `flutter pub get`
- ✅ Execução automática de `dart run slang`

### 🚀 Próximas Funcionalidades
- [ ] Geração de componentes UI
- [ ] Geração de páginas com roteamento
- [ ] Geração de testes unitários
- [ ] Geração de widgets customizados
- [ ] Integração com Melos para workspace

## Contribuição

Para adicionar novos comandos ou funcionalidades à CLI:

1. Edite o arquivo `lib/artizan_cli.dart`
2. Adicione novos comandos no `ArgParser`
3. Implemente a lógica no método `main`
4. Teste a funcionalidade
5. Atualize esta documentação

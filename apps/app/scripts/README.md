# Gerador de Slang Wrapper

Este script automatiza a geração do arquivo `slang_wrapper.dart` baseado nas dependências encontradas no `pubspec.yaml`.

## Como funciona

O script lê o arquivo `pubspec.yaml` e procura por dependências que:
- Têm um `path` (dependências locais)
- Contêm o diretório `lib/i18n` no package
- **NÃO** estão marcadas com `# ignore-slang`

## Dependências suportadas

O script processa apenas dependências que:
- Têm um `path` que aponta para um diretório local
- Contêm o diretório `lib/i18n` no package
- Não estão marcadas com `# ignore-slang`

## Como usar

### Executar o gerador:
```bash
dart scripts/generate_slang.dart
```

## Exemplo de uso

1. Adicione suas dependências no `pubspec.yaml`:
```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # Este package será ignorado
  core: # ignore-slang
    path: ../../packages/core
  
  # Este package será processado
  ui:
    path: ../../packages/ui
  
  # Este package será processado
  auth:
    path: ../../features/auth
```

2. Execute o script:
```bash
dart scripts/generate_slang.dart
```

3. O arquivo `lib/slang_wrapper.dart` será gerado automaticamente.

## Arquivo gerado

O script gera um arquivo com:
- Imports para todas as dependências encontradas (exceto as marcadas com `# ignore-slang`)
- Uma classe `SlangWrapperAppWidget` que aninha todos os `TranslationProvider`
- Estrutura correta para uso com o Slang

## Ignorando packages

Para ignorar um package, adicione `# ignore-slang` na linha do package:

```yaml
dependencies:
  package_ignorado: # ignore-slang
    path: ../../packages/ignorado
```

## Estrutura do pubspec.yaml

Certifique-se de que suas dependências estejam formatadas assim:
```yaml
dependencies:
  # Package que será ignorado
  core: # ignore-slang
    path: ../../packages/core
  
  # Package que será processado
  ui:
    path: ../../packages/ui
``` 
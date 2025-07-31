# Paipfood Backend

This is the backend API for the Paipfood application built with Dart Frog.

## Prerequisites

- Dart SDK 3.6.0 or higher
- Docker (for containerization)

## Getting Started

1. Install dependencies:
```bash
dart pub get
```

2. Copy environment file:
```bash
cp dev.env .env
```

3. Run development server:
```bash
./run_dev.sh
```

## Docker Issues Fixed

### PathNotFoundException com Hive Database

**Problema:** Ao executar no Docker, o endpoint `/v1/address/auto_complete` falha com erro:
```
PathNotFoundException: Creation failed, path = '' (OS Error: No such file or directory, errno = 2)
```

**Causa:** O Hive (banco de dados local) estava sendo inicializado com `Directory.current.path` que pode estar vazio no Docker.

**Soluções implementadas:**

1. **Inicialização robusta do Hive** em `lib/src/services/initialize_service.dart`:
   - Detecta se o path atual está vazio
   - Usa `/tmp/hive_db` como fallback no Docker
   - Cria o diretório automaticamente se não existir
   - Adiciona logs para debug

2. **Tratamento de erro no MapboxCache** em `lib/src/caches/mapbox_cache.dart`:
   - Try/catch em todas as operações do Hive
   - Gera tokens temporários se não conseguir persistir
   - Continua funcionando mesmo sem cache persistente

### Como testar a correção:

1. Rebuild da imagem Docker:
```bash
./compose.sh
```

2. Verificar logs durante inicialização:
```bash
docker logs paipfood_api
```

3. Testar endpoint problemático:
```bash
curl -X POST http://localhost:8090/v1/address/auto_complete \
  -H "Content-Type: application/json" \
  -d '{
    "query": "Rua",
    "locale": "pt_BR",
    "provider": "google"
  }'
```

O endpoint agora deve funcionar tanto localmente quanto no Docker, mesmo que o cache não possa ser persistido.

## Environment Variables

Make sure your `.env` file contains all required variables. Check `dev.env` for reference.

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]
[![Powered by Dart Frog](https://img.shields.io/endpoint?url=https://tinyurl.com/dartfrog-badge)](https://dartfrog.vgv.dev)

An example application built with dart_frog

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
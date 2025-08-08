# Correção do Erro "Position update is unavailable" no Geolocator Web

## Problema
O erro `RethrownDartError: Position update is unavailable` ocorre quando o geolocator_web não consegue obter a posição do usuário devido a problemas de permissão ou configuração no navegador.

## Soluções Implementadas

### 1. Tratamento de Erro no MyPositionService
- Adicionado tratamento específico para o erro "Position update is unavailable"
- Implementado fallback para localização baseada em IP quando o geolocator falha
- Adicionada verificação para detectar se está rodando na web

### 2. Configuração de Permissões HTML
- Adicionada meta tag `permissions-policy` com `geolocation=(self)` nos arquivos HTML de todos os apps
- Isso permite que o navegador solicite permissão de geolocalização

### 3. Inicialização Específica para Web
- Criada inicialização específica para geolocator na web no `InitializeWebService`
- Verificação de permissões e serviços de localização antes de usar o geolocator

## Arquivos Modificados

### Core
- `features/address/lib/src/data/services/my_position_service.dart`
- `apps/app/lib/src/core/data/services/config/initialize_web_service.dart`

### HTML Files
- `apps/app/web/index.html`
- `apps/_app/web/index.html`
- `apps/manager/web/index.html`
- `apps/portal/web/index.html`

## Como Funciona

1. **Na Web**: O sistema primeiro tenta obter a localização baseada em IP
2. **Fallback**: Se o geolocator falhar com "Position update is unavailable", usa localização baseada em IP
3. **Permissões**: As meta tags HTML permitem que o navegador solicite permissão de geolocalização
4. **Inicialização**: O `InitializeWebService` verifica e solicita permissões adequadamente

## Teste
Para testar se a correção funcionou:
1. Execute o app na web
2. Verifique se não há mais erros de "Position update is unavailable"
3. Confirme que a localização está sendo obtida (mesmo que via IP)

## Notas
- A localização baseada em IP é menos precisa que GPS, mas é uma solução adequada para web
- O sistema continua tentando usar geolocator primeiro, só usa IP como fallback
- As permissões são solicitadas adequadamente pelo navegador

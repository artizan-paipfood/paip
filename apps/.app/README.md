# PaipFood App

## Correções Recentes

### 🚚 Taxa de Entrega - v1.0.1
- **Corrigido**: Problema onde taxa de entrega às vezes não era aplicada
- **Melhorado**: Sistema de cache mais robusto para taxas de entrega
- **Adicionado**: Logs de debug para facilitar troubleshooting (apenas em desenvolvimento)
- **Otimizado**: Performance na interface de seleção de endereços

**Arquivos modificados:**
- `lib/src/core/notifiers/delivery_area_notifier.dart`
- `lib/src/modules/menu/presenters/view_models/menu_viewmodel.dart`
- `lib/src/modules/menu/presenters/components/card_option_order_delivery.dart`
- `lib/src/core/utils/delivery_tax_debug.dart`

---

## Desenvolvimento

### Debug da Taxa de Entrega
Em modo de desenvolvimento, o sistema exibe logs detalhados da taxa de entrega:
- Cache de taxas
- Cálculos de distância
- Estados de endereços
- Possíveis problemas identificados

### Como Testar
1. Execute o app em modo debug
2. Faça pedidos com entrega
3. Mude endereços durante o pedido
4. Observe os logs no console

## Produção

### Logs
- Todos os logs de debug são automaticamente removidos em builds de produção
- Nenhuma informação sensível é exposta nos logs
- Performance otimizada para produção

### Cache de Taxa
- Sistema de cache inteligente reduz chamadas à API
- Timeout de 30 segundos para evitar travamentos
- Limpeza automática de cache quando necessário
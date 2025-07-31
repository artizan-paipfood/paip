# Documentação do Backend para Integração com Stripe

Esta documentação detalha os fluxos de operação para integração com a API do Stripe, centrando-se na criação de sessões de pagamento, gerenciamento de transferências e processamento de reembolsos. A implementação está baseada na interface abstrata `IStripeRepository`, que fornece um conjunto de funções para interagir com a API do Stripe.

## Tabela de Conteúdos
- [Referência da API](#referência-da-api)
- [Fluxo de Split de Pagamentos](#fluxo-de-split-de-pagamentos)
- [Fluxo de Reembolso](#fluxo-de-reembolso)
- [Considerações](#considerações)

## Referência da API

- [Stripe API - Create Checkout Session](https://docs.stripe.com/api/checkout/sessions/create?lang=curl)
---
## Fluxo de Split de Pagamentos

### Descrição

O fluxo de split é usado para processar uma sessão de checkout, verificar o pagamento, e distribuir os fundos entre diferentes contas após o recebimento.

### Etapas do Fluxo

1. **Criação de Sessão de Pagamento**
   - **Função**: `checkoutCreateSession`
   - **Descrição**: Cria uma sessão de pagamento no Stripe.

   ```dart
   final sessionResponse = await stripeRepository.checkoutCreateSession(
     description: "Compra de Produto X",
     amount: 49.99,
     country: "BR",
     successUrl: "https://seusite.com/success",
     cancelUrl: "https://seusite.com/cancel",
     orderId: "12345",
   );
   ```

2. **Recuperação da Sessão de Checkout**
   - **Função**: `retrieveCheckoutSession`
   - **Descrição**: Recupera informações sobre a sessão para verificar se o pagamento foi concluído.

   ```dart
   final sessionDetails = await stripeRepository.retrieveCheckoutSession(
     paymentId: sessionResponse.id,
     country: "BR",
   );
   ```

3. **Recuperação do Intent de Pagamento**
   - **Função**: `retrievePaymentIntent`
   - **Descrição**: Recupera o `latest_charge` associado à intenção de pagamento.

   ```dart
   final paymentIntentDetails = await stripeRepository.retrievePaymentIntent(
     paymentIntentId: sessionDetails.paymentIntentId,
     country: "BR",
   );
   ```

4. **Recuperação da Cobrança**
   - **Função**: `retrieveCharge`
   - **Descrição**: Obtém o `balance_transaction` da cobrança.

   ```dart
   final chargeDetails = await stripeRepository.retrieveCharge(
     chargeId: paymentIntentDetails.latestCharge,
     country: "BR",
   );
   ```

5. **Recuperação da Transação de Balanço**
   - **Função**: `retrieveBalanceTransaction`
   - **Descrição**: Avalia o valor líquido (`net`) da transação para divisão de comissões.

   ```dart
   final balanceTransaction = await stripeRepository.retrieveBalanceTransaction(
     transactionId: chargeDetails.balanceTransaction,
     country: "BR",
   );
   ```

6. **Transferência de Fundos**
   - **Função**: `transfer`
   - **Descrição**: Transfere os fundos líquidos para diferentes contas conforme a divisão de comissões.

   ```dart
   final transferDetails = await stripeRepository.transfer(
     chargeId: chargeDetails.id,
     accountId: "acct_67890",
     amount: balanceTransaction.net / 2, // Exemplo de divisão de valores
     country: "BR",
   );
   ```
---
## Fluxo de Reembolso

### Descrição

Este fluxo descreve como realizar reembolsos de transações, possibilitando tanto reembolsos totais quanto parciais.

### Etapas do Fluxo

1. **Reversão das Transferências**
   - **Função**: `reverseTransfer`
   - **Descrição**: Reverte todas as transferências realizadas anteriormente.

   ```dart
   final transferReversal = await stripeRepository.reverseTransfer(
     transferId: transferDetails.id,
     country: "BR",
     amount: 5.00, // Exemplo de reversão parcial de $5.00
   );
   ```

2. **Reembolso ao Cliente**
   - **Função**: `refund`
   - **Descrição**: Efetua o reembolso ao cliente, permitindo reembolsos parciais através do parâmetro `amount`.

   ```dart
   final refundDetails = await stripeRepository.refund(
     paymentIntent: paymentIntentDetails.id,
     country: "BR",
     amount: 20.00, // Exemplo de reembolso parcial de $20.00
   );
   ```
---
### Considerações

- **Parâmetros `amount`**: Nas operações de reversão e reembolso, o parâmetro `amount` deve ser especificado para realizar reversões ou reembolsos parciais.
- **Monitoramento e Segurança**: As chamadas para a API do Stripe devem ser executadas em um ambiente seguro e devem incluir mecanismos de tratamento de erros adequados.
- **Ambiente de Teste**: Recomenda-se testar as integrações com as chaves de teste do Stripe antes de lançar em produção.

Esta documentação serve como um guia para implementar e executar fluxos de pagamento e reembolso eficazes usando a API do Stripe através da interface Dart `IStripeRepository`.
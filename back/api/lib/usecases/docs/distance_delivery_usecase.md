# Documentação do Backend para o Caso de Uso de Distância de Entrega

Esta documentação detalha a classe `DistanceDeliveryUsecase`, que é responsável pela lógica de negócios relacionada ao cálculo de taxas de entrega e distâncias entre usuários e estabelecimentos. A classe utiliza repositórios para acessar dados de endereços e áreas de entrega.

## Tabela de Conteúdos
- [Estrutura da Classe](#estrutura-da-classe)
- [Métodos Principais](#métodos-principais)
  - [Calcular Taxa de Entrega](#1-calcular-taxa-de-entrega)
  - [Obter Taxa de Entrega por Polígono](#2-obter-taxa-de-entrega-por-polígono)
  - [Calcular Distância](#3-calcular-distância)

---

## Estrutura da Classe

A classe `DistanceDeliveryUsecase` depende de dois repositórios:
- **`IAddressRepository`**: Para interações relacionadas a endereços.
- **`IAddressUserEstablishmentRepository`**: Para interações relacionadas aos endereços de usuários em estabelecimentos.

```dart
class DistanceDeliveryUsecase {
  final IAddressRepository addressRespository;
  final IAddressUserEstablishmentRepository addressUserEstablishmentRepository;

  DistanceDeliveryUsecase({
    required this.addressRespository,
    required this.addressUserEstablishmentRepository,
  });
}
```

---

## Métodos Principais

### 1. Calcular Taxa de Entrega

- **Método**: `getDeliveryTax`
- **Descrição**: Calcula a taxa de entrega com base na localização do usuário e do estabelecimento, e no método de entrega especificado. Se o método de entrega for "milhas", calcula a distância utilizando as coordenadas; caso contrário, obtém a taxa de entrega por polígono.

```dart
Future<DeliveryTaxResponse> getDeliveryTax({
  required String establishmentId,
  required double lat,
  required double long,
  required double establishmentLat,
  required double establishmentLong,
  required DeliveryMethod deliveryMethod,
  String? userAddressId,
  String? establishmentAddressId,
});
```

#### Exemplo de Uso

```dart
final deliveryTax = await distanceDeliveryUsecase.getDeliveryTax(
  establishmentId: "estab_123456",
  lat: -23.5505,
  long: -46.6333,
  establishmentLat: -22.9068,
  establishmentLong: -43.1729,
  deliveryMethod: DeliveryMethod.miles,
);
```

---

### 2. Obter Taxa de Entrega por Polígono

- **Método**: `getDeliveryTaxPolygon`
- **Descrição**: Obtém a taxa de entrega para uma área específica baseada na localização do usuário e do estabelecimento.

```dart
Future<DeliveryTaxPolygonResponse> getDeliveryTaxPolygon({
  required String establishmentId,
  required double lat,
  required double long,
});
```

#### Exemplo de Uso

```dart
final deliveryTaxPolygon = await distanceDeliveryUsecase.getDeliveryTaxPolygon(
  establishmentId: "estab_123456",
  lat: -23.5505,
  long: -46.6333,
);
```

---

### 3. Calcular Distância

- **Método**: `getDistance`
- **Descrição**: Calcula a distância entre um ponto de origem (localização do usuário) e um ponto de destino (localização do estabelecimento). O método também pode armazenar a distância calculada no banco de dados para evitar cálculos futuros.

```dart
Future<DistanceDto> getDistance({
  required double originlat,
  required double originlong,
  required double destlat,
  required double destlong,
  String? userAddressId,
  String? establishmentAddressId,
});
```

#### Exemplo de Uso

```dart
final distance = await distanceDeliveryUsecase.getDistance(
  originlat: -23.5505,
  originlong: -46.6333,
  destlat: -22.9068,
  destlong: -43.1729,
  userAddressId: "user_123456",
  establishmentAddressId: "estab_123456",
);
```

---

## Considerações

- **Validação das Entradas**: É fundamental validar as entradas antes de chamar os métodos para garantir que os dados estão corretos.
- **Tratamento de Erros**: Implementar um tratamento de erros adequado para gerenciar possíveis falhas na comunicação com o repositório ou cálculos de distância.

Esta documentação serve como um guia para entender e usar a classe `DistanceDeliveryUsecase`, incluindo suas interações com repositórios e sua funcionalidade na lógica de entrega.

enum ChargeStatus {
  canceled, // cancelado
  refunded, // estornado
  pending, // pagamento pendente
  paid, // pago (nao processado)
  processed; // processado (splits feitos)

  static ChargeStatus fromMap(String value) => ChargeStatus.values.firstWhere((cs) => cs.name == value);
}

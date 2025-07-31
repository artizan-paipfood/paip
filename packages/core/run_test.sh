#!/bin/bash

echo "Qual teste você quer rodar?"
echo "1) Testes Unitários"
echo "2) Testes End-to-End"
read -p "Digite o número: " option

if [ "$option" == "1" ]; then
  echo "Rodando apenas testes unitários..."
  flutter test $(find test -name '*.dart' ! -name '*e2e_test.dart')
elif [ "$option" == "2" ]; then
  echo "Rodando apenas testes E2E..."
  flutter test $(find test -name '*e2e_test.dart')
else
  echo "Opção inválida."
  exit 1
fi

#!/bin/bash
#  chmod +x env_dev.sh
# ./env_dev.sh
# Carregar as variáveis do arquivo .env
export $(grep -v '^#' dev.env | xargs)

# Iniciar o Dart Frog em modo de depuração usando a porta definida no .env
cat dev.env ; dart_frog dev --port=$PORT

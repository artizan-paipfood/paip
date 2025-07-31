#!/bin/bash

# Caminho para o arquivo de entrada (app_en.arb)
INPUT_FILE="lib/l10n/app_en.arb"
# Caminho para o arquivo de saída (i18n.dart)
OUTPUT_FILE="lib/l10n/i18n.dart"

# Verifica se o arquivo de entrada existe
if [ ! -f "$INPUT_FILE" ]; then
    echo "Arquivo $INPUT_FILE não encontrado!"
    exit 1
fi

# Extrai as chaves do arquivo .arb
KEYS=$(jq -r 'keys[]' "$INPUT_FILE")

# Inicia o arquivo Dart
echo "class I18n {" > "$OUTPUT_FILE"
echo "  I18n._();" >> "$OUTPUT_FILE"
echo >> "$OUTPUT_FILE"

# Adiciona as chaves extraídas
for KEY in $KEYS; do
    echo "  static String $KEY = \"$KEY\";" >> "$OUTPUT_FILE"
done

echo "}" >> "$OUTPUT_FILE"

echo "Arquivo $OUTPUT_FILE gerado com sucesso!"

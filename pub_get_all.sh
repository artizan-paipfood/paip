#!/bin/bash

# Função para executar os comandos em um diretório
execute_commands() {
    local dir=$1
    if [ -f "$dir/pubspec.yaml" ]; then
        echo "Processando $dir..."
        cd "$dir"
        flutter clean
 flutter pub get
        cd - > /dev/null
    fi
}

echo "Processando packages primeiro..."
# Processar todos os diretórios em packages/
for dir in packages/*/; do
    if [ -d "$dir" ]; then
        execute_commands "$dir"
    fi
done

echo "Agora processando apps..."
# Processar todos os diretórios em apps/
for dir in apps/*/; do
    if [ -d "$dir" ]; then
        execute_commands "$dir"
    fi
done

echo "Processo concluído!" 
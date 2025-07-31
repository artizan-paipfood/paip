#!/bin/bash

echo "🚀 Instalando Artizan CLI..."

# Executar pub get para garantir que as dependências estão instaladas
echo "📦 Instalando dependências..."
dart pub get

# Ativar globalmente o package
echo "🌍 Ativando globalmente..."
dart pub global activate --source path .

# Verificar se foi instalado corretamente
echo ""
echo "✅ Instalação concluída!"
echo ""
echo "🎯 Teste a instalação com:"
echo "   artizan --help"
echo ""
echo "💡 Se o comando não for encontrado, adicione ao PATH:"
echo "   export PATH=\"\$PATH:\$(dart pub global bin)\""
echo "   # Adicione esta linha ao seu ~/.zshrc ou ~/.bashrc"
echo ""
echo "📋 Comandos disponíveis:"
echo "   artizan feature <nome>    - Criar nova feature"
echo "   artizan feature -h        - Ver arquitetura das features"
echo "   artizan version           - Ver versão"
echo "" 
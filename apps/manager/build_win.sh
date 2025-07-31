#!/bin/bash
# Dê permissão com: chmod +x build_win.sh
# Execute com: ./build_win.sh

# 1 - Deletar pasta build
echo -e "\033[33m🧹 Deletando pasta build...\033[0m"
rm -rf build

# 2 - Deletar pubspec.lock
echo -e "\033[33m🧹 Deletando pubspec.lock...\033[0m"
rm -f pubspec.lock

# 3 - flutter clean (puro)
echo -e "\033[34m🚿 Executando flutter clean...\033[0m"
flutter clean

# 4 - Instalando dependências
echo -e "\033[34m📦 Instalando dependências...\033[0m"
puro flutter pub get

# 5 - Rodando testes unitarios (excluindo e2e)
echo -e "\033[36m🧪 Rodando testes unitários...\033[0m"
flutter test $(find test -type f ! -name '*_e2e_test.dart')

# Verificando se os testes passaram
if [ $? -ne 0 ]; then
  echo -e "\033[31m❌ Testes falharam. Abortei a build.\033[0m"  
  # Espera por 10 minutos (600 segundos)
  sleep 600
  
  exit 1
fi

# 6 - Atualizando versão no gestor.iss
echo -e "\033[34m📝 Atualizando versão no gestor.iss...\033[0m"
VERSION=$(grep "version:" pubspec.yaml | cut -d' ' -f2)
sed -i "s/#define MyAppVersion \".*\"/#define MyAppVersion \"$VERSION\"/" gestor.iss

# 7 - flutter build
echo -e "\033[32m🏗️  Construindo app Windows...\033[0m"
puro flutter build windows --dart-define-from-file=../../prod.env --release

# Final
echo -e "\033[32m✅ Processo concluído com sucesso!\033[0m"
sleep 600


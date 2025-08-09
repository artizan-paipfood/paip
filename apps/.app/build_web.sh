#!/bin/bash

# Diretório do script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"


JS_FILE="$SCRIPT_DIR/web/flutter_bootstrap.js"


generate_random_version() {
    DATE=$(date +"%Y%m%d")
    TIME=$(date +"%H%M%S")
    RANDOM_HASH=$(openssl rand -hex 3)
    echo "${DATE}.${TIME}.${RANDOM_HASH}"
}


get_service_worker_version() {
    git rev-parse --short HEAD 2>/dev/null || echo "default"
}

# Verifica se o arquivo existe
if [ ! -f "$JS_FILE" ]; then
    echo "Erro: flutter_bootstrap.js não encontrado!"
    exit 1
fi

# Gera versões
VERSION=$(generate_random_version)
SERVICE_WORKER_VERSION=$(get_service_worker_version)

# Substitui a versão no arquivo - Note a flag -i '' para macOS
sed -i '' "s/{{app_version}}/$VERSION/g" "$JS_FILE"

# Substitui a versão do service worker - Note a flag -i '' para macOS
sed -i '' "s/{{service_worker_version}}/$SERVICE_WORKER_VERSION/g" "$JS_FILE"
echo "🗑️ Excluindo pasta build..."
rm -r ./build

echo "🗑️ Excluindo pubspec.lock..."
rm -r ./pubspec.lock

echo "🚿 Limpando projeto..."
flutter clean

echo "📦 Instalando dependencias..."
flutter pub get

echo "🚀 Build iniciado"
echo "📦 Versão Gerada: $VERSION"
echo "🔧 Versão do Service Worker: $SERVICE_WORKER_VERSION"

# Realiza o build
# flutter clean
# flutter pub get
flutter build web \
  --dart-define-from-file=../../prod.env 

# Reseta o arquivo de versionamento flutter web
git checkout -- "$JS_FILE"

echo "✅ Build concluído com sucesso!"

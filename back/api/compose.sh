#!/bin/bash
# chmod +x compose.sh
# ./compose.sh

# Verifica se o arquivo .env existe
if [[ ! -f .env ]]; then
    echo "Erro: Arquivo .env não encontrado!"
    exit 1
fi

# Remover os comentários do arquivo .env e criar um arquivo temporário sem comentários
grep -v '^#' .env | grep -E '.+=' > .env.temp

# Verifica se o arquivo .env.temp foi gerado corretamente
if [[ ! -s .env.temp ]]; then
    echo "Erro: Arquivo .env.temp está vazio ou ocorreu um problema ao processar o .env."
    rm -f .env.temp
    exit 1
fi

# Variável para armazenar a porta
PORT_NUMBER=""

# Ler as variáveis do arquivo .env.temp para capturar a porta
while IFS= read -r line; do
    if [[ "$line" == PORT=* ]]; then
        PORT_NUMBER=${line#PORT=}
        break
    fi
done < .env.temp

# Verificar se a porta foi encontrada
if [[ -z "$PORT_NUMBER" ]]; then
    echo "Erro: Porta não encontrada no arquivo .env!"
    rm -f .env.temp
    exit 1
fi

echo "Porta encontrada: $PORT_NUMBER"

# Inicializar o docker-compose.yml
cat <<EOL > docker-compose.yml
services:
  paipfood_api:
    container_name: paipfood_api
    image: eduardohrmuniz/paipfood_api:latest
    restart: unless-stopped
    ports:
      - "$PORT_NUMBER:$PORT_NUMBER"
    environment:
EOL

# Adicionar as variáveis de ambiente ao docker-compose.yml
while IFS= read -r env_line; do
    # Converte a linha de CHAVE=VALOR para CHAVE: "VALOR"
    IFS='=' read -r key value <<< "$env_line"
    # Remove espaços em branco do início e fim de valor
    key=$(echo "$key" | xargs)
    value=$(echo "$value" | xargs)
    # Adiciona ao arquivo docker-compose.yml
    echo "      $key: \"$value\"" >> docker-compose.yml
done < .env.temp

# Remover o arquivo temporário
rm -f .env.temp

# Exibir o docker-compose.yml gerado
echo -e "\nConteúdo do arquivo docker-compose.yml:"
cat docker-compose.yml

# Exibir mensagem de sucesso
echo -e "\ndocker-compose.yml criado com sucesso!"

echo -e "\n🚀 Iniciando build multi-plataforma para Linux..."

# Fazer build multi-plataforma diretamente para o Docker Hub
docker buildx build \
  --platform linux/amd64 \
  --tag eduardohrmuniz/paipfood_api:latest \
  --tag eduardohrmuniz/paipfood_api:linux-amd64 \
  --push .

# Verificar se o build foi bem-sucedido
if [[ $? -eq 0 ]]; then
    echo -e "\n✅ Build e push concluídos com sucesso!"
    echo -e "\n📋 Para executar a imagem em um servidor Linux:"
    echo -e "\n🐳 Com arquivo .env:"
    echo -e "docker run -d --name paipfood_api --restart unless-stopped -p $PORT_NUMBER:$PORT_NUMBER --env-file .env eduardohrmuniz/paipfood_api:latest"
    
    echo -e "\n🔄 Para fazer update (se já estiver rodando):"
    echo -e "docker stop paipfood_api && docker rm paipfood_api && docker pull eduardohrmuniz/paipfood_api:latest"
    echo -e "docker run -d --name paipfood_api --restart unless-stopped -p $PORT_NUMBER:$PORT_NUMBER --env-file .env eduardohrmuniz/paipfood_api:latest"
else
    echo -e "\n❌ Erro durante o build! Verifique os logs acima."
    exit 1
fi
  

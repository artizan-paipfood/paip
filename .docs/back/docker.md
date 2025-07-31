# 🐳 Docker - PaipFood API

## 🛠️ 1. Configuração Inicial


### 1.2 Login no Docker Hub

Faça login no Docker Hub antes de fazer push das imagens:

```bash
docker login -u eduardohrmuniz
```

Digite suas credenciais quando solicitado.

## 📦 2. Build Local (Desenvolvimento)

Atualize ou adicione seu arquivo .env no diretório da sua API e execute o seguinte comando:

```shell
docker run -d --name paipfood_api -p 8090:8090 --env-file .env eduardohrmuniz/paipfood_api:latest
```

## 🐛 3. Debug e Monitoramento

### 3.1 Visualizar Logs do Container

Para acompanhar os logs em tempo real:

```bash
docker logs -f paipfood_api
```

Para visualizar apenas as últimas linhas:

```bash
docker logs --tail 100 paipfood_api
```

### 3.2 Acessar o Container

Para entrar no container e debugar internamente:

```bash
docker exec -it paipfood_api /bin/bash
```

### 3.3 Verificar Status dos Containers

Listar todos os containers (ativos e parados):

```bash
docker ps -a
```

Verificar uso de recursos:

```bash
docker stats paipfood_api
```

## 🔄 4. Atualizar Projeto em Execução

### 4.1 Atualizar para Nova Versão

Para atualizar um container que já está rodando:

```bash
# 1. Parar o container atual
docker stop paipfood_api

# 2. Baixar a nova versão da imagem
docker pull eduardohrmuniz/paipfood_api:latest

# 3. Remover o container antigo
docker rm paipfood_api

# 4. Executar o novo container
docker run -d --name paipfood_api -p 8090:8090 --env-file .env eduardohrmuniz/paipfood_api:latest
```

### 4.2 Script de Atualização Rápida

Você pode criar um script para automatizar o processo:

```bash
#!/bin/bash
echo "🔄 Atualizando PaipFood API..."
docker stop paipfood_api
docker pull eduardohrmuniz/paipfood_api:latest
docker rm paipfood_api
docker run -d --name paipfood_api -p 8090:8090 --env-file .env eduardohrmuniz/paipfood_api:latest
echo "✅ Atualização concluída!"
```

## 🛑 5. Gerenciamento de Containers

### 5.1 Parar Container

```bash
docker stop paipfood_api
```

### 5.2 Reiniciar Container

```bash
docker restart paipfood_api
```

### 5.3 Remover Container

```bash
# Parar e remover o container
docker stop paipfood_api
docker rm paipfood_api
```

### 5.4 Limpeza Completa

Para remover tudo relacionado ao projeto:

```bash
# Parar e remover container
docker stop paipfood_api
docker rm paipfood_api

# Remover imagem (opcional)
docker rmi eduardohrmuniz/paipfood_api:latest

# Limpeza geral do Docker (remove imagens não utilizadas)
docker system prune -f
```

## 📝 6. Comandos Úteis

### 6.1 Verificar Portas em Uso

```bash
# Verificar se a porta 8090 está em uso
lsof -i :8090

# No Docker
docker port paipfood_api
```

### 6.2 Backup de Dados (se aplicável)

Se o container usar volumes para dados persistentes:

```bash
# Listar volumes
docker volume ls

# Fazer backup de um volume
docker run --rm -v volume_name:/data -v $(pwd):/backup alpine tar czf /backup/backup.tar.gz /data
```

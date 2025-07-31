# 🚀 Instalação Rápida - Artizan CLI

## Instalação Global (Recomendado)

### Passo 1: Executar o script de instalação
```bash
cd packages/artizan_cli
./install.sh
```

### Passo 2: Testar a instalação
```bash
artizan --help
```

### Passo 3: Criar sua primeira feature
```bash
artizan feature minha_feature
```

## ✅ Pronto!

Agora você pode usar o comando `artizan` de qualquer lugar do sistema.

## 🔧 Solução de Problemas

### Se o comando `artizan` não for encontrado:

1. **Adicione ao PATH:**
   ```bash
   echo 'export PATH="$PATH:$(dart pub global bin)"' >> ~/.zshrc
   source ~/.zshrc
   ```

2. **Ou execute diretamente:**
   ```bash
   dart pub global run artizan_cli:artizan_cli --help
   ```

### Se houver problemas com dependências:

```bash
cd packages/artizan_cli
dart pub get
dart pub global activate --source path .
```

## 📋 Comandos Disponíveis

- `artizan help` - Mostrar ajuda
- `artizan version` - Mostrar versão
- `artizan feature <nome>` - Criar nova feature

## 🎯 Exemplos de Uso

```bash
# Criar feature de autenticação
artizan feature auth

# Criar feature de usuário
artizan feature user

# Criar feature de pedidos
artizan feature orders
``` 
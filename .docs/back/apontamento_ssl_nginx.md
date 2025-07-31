# Configuração de Nginx e SSL com Certbot

## Passo 1: Adicionar o Apontamento no Nginx

Na pasta `nginx/sites-available`, adicione um novo arquivo de configuração para o seu domínio/apontamento.

### Exemplo de configuração:

```nginx
server {
    listen 80;
    listen [::]:80;
    server_name {apontamento}.paipfood.com;

    location / {
        proxy_pass http://localhost:{porta};
        
        # Configurações CORS
        add_header 'Access-Control-Allow-Origin' '*';
        add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
        add_header 'Access-Control-Allow-Headers' 'DNT,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Range';
        add_header 'Access-Control-Expose-Headers' 'Content-Length,Content-Range';
        add_header 'Access-Control-Allow-Credentials' 'true' always;
        add_header 'Access-Control-Max-Age' 1728000;
    }

    location /.well-known/acme-challenge/ {
        root /var/www/html;
    }
}
```

Substitua `{apontamento}` pelo seu subdomínio e `{porta}` pela porta correta da sua aplicação.

## Passo 2: Testar e Reiniciar o Nginx

Após configurar o Nginx, execute os seguintes comandos para validar e aplicar as configurações:

```sh
sudo nginx -t
sudo systemctl restart nginx
sudo systemctl status nginx
```

Se tudo estiver correto, vamos configurar o certificado SSL.

## Passo 3: Gerar Certificado SSL com Certbot

Para gerar o certificado SSL para seu apontamento, execute:

```sh
sudo certbot --nginx -d {apontamento}.paipfood.com
```

Se precisar renovar forçadamente o certificado, use:

```sh
sudo certbot certonly --nginx --force-renewal -d {apontamento}.paipfood.com
```

## Passo 4: Testar e Reiniciar o Nginx Novamente

Após a geração do certificado, execute os comandos abaixo:

```sh
sudo nginx -t
sudo systemctl restart nginx
sudo systemctl status nginx
```

## Passo 5: Verificar a Configuração do Certbot no Nginx

Agora, abra novamente o arquivo de configuração no Nginx e verifique se a configuração SSL foi adicionada corretamente.

### Exemplo de configuração esperada:

```nginx
server {
    server_name {apontamento}.paipfood.com;

    location / {
        proxy_pass http://localhost:{porta};
        # Configurações CORS
        add_header 'Access-Control-Allow-Origin' '*';
        add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
        add_header 'Access-Control-Allow-Headers' 'DNT,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Range';
        add_header 'Access-Control-Expose-Headers' 'Content-Length,Content-Range';
        add_header 'Access-Control-Allow-Credentials' 'true' always;
        add_header 'Access-Control-Max-Age' 1728000;
    }

    location /.well-known/acme-challenge/ {
        root /var/www/html;
    }

    listen [::]:443 ssl; # managed by Certbot // 👋 ⬇️
    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/{apontamento}.paipfood.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/{apontamento}.paipfood.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

}

server {
    if ($host = {apontamento}.paipfood.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 80;
    listen [::]:80;
    server_name {apontamento}.paipfood.com;
    return 404; # managed by Certbot
```

## Conclusão

Após seguir todos os passos, seu domínio `{apontamento}.paipfood.com` estará configurado corretamente com HTTPS e pronto para uso! 🚀


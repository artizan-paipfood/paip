{{flutter_js}}
{{flutter_build_config}}

const appVersion = '{{app_version}}' || '1.0.0'; 
const serviceWorkerVersion = '{{service_worker_version}}' || 'default-sw-version';

// Função para verificar e limpar cache se versão mudou
async function checkVersionAndClearCache() {
    const currentVersion = appVersion;
    const storedVersion = localStorage.getItem('app_version');
    
    console.log('🔍 Verificando versão...');
    console.log('Versão atual:', currentVersion);
    console.log('Versão armazenada:', storedVersion);
    
    // Lista todas as chaves do localStorage para debug
    const allKeys = Object.keys(localStorage);
    console.log('📦 Chaves atuais no localStorage:', allKeys);
    console.log(`📊 Total de ${allKeys.length} chaves encontradas`);
    
    if (storedVersion && storedVersion !== currentVersion) {
        console.log('🆕 Nova versão detectada! Limpando cache...');
        
        try {
            // Limpa localStorage (mantém apenas dados essenciais se necessário)
            const essentialKeys = ['user_preferences', 'auth_token']; // Adicione chaves que quer manter
            const essentialData = {};
            
            console.log('🔒 Chaves essenciais configuradas:', essentialKeys);
            
            // Identifica quais chaves essenciais existem
            const foundEssentialKeys = [];
            essentialKeys.forEach(key => {
                const value = localStorage.getItem(key);
                if (value) {
                    essentialData[key] = value;
                    foundEssentialKeys.push(key);
                }
            });
            
            console.log('💾 Chaves essenciais encontradas e preservadas:', foundEssentialKeys);
            
            // Lista chaves que serão removidas
            const keysToRemove = allKeys.filter(key => !essentialKeys.includes(key));
            console.log('🗑️ Chaves que serão removidas:', keysToRemove);
            console.log(`📊 ${keysToRemove.length} chaves serão removidas, ${foundEssentialKeys.length} serão preservadas`);
            
            localStorage.clear();
            
            // Restaura dados essenciais
            Object.keys(essentialData).forEach(key => {
                localStorage.setItem(key, essentialData[key]);
            });
            
            // Limpa sessionStorage
            const sessionKeys = Object.keys(sessionStorage);
            console.log('🗂️ Chaves no sessionStorage:', sessionKeys);
            console.log(`📊 ${sessionKeys.length} chaves do sessionStorage serão removidas`);
            sessionStorage.clear();
            
            // Limpa cache do service worker
            if ('caches' in window) {
                const cacheNames = await caches.keys();
                console.log('🗄️ Caches encontrados:', cacheNames);
                await Promise.all(
                    cacheNames.map(cacheName => {
                        console.log('🗑️ Removendo cache:', cacheName);
                        return caches.delete(cacheName);
                    })
                );
            }
            
            // Desregistra service workers antigos
            if ('serviceWorker' in navigator) {
                const registrations = await navigator.serviceWorker.getRegistrations();
                console.log(`🔄 ${registrations.length} service workers encontrados para desregistrar`);
                await Promise.all(
                    registrations.map(registration => {
                        console.log('🔄 Desregistrando service worker');
                        return registration.unregister();
                    })
                );
            }
            
            // 🚀 FORÇA LIMPEZA MAIS AGRESSIVA DO CACHE DE REDE
            if ('caches' in window && window.caches) {
                try {
                    // Remove TODOS os caches possíveis
                    const allCacheNames = await caches.keys();
                    await Promise.all(allCacheNames.map(name => caches.delete(name)));
                    console.log('🧹 Todos os caches de rede removidos');
                } catch (error) {
                    console.log('⚠️ Erro ao limpar caches de rede:', error);
                }
            }
            
            // Armazena nova versão
            localStorage.setItem('app_version', currentVersion);
            
            console.log('✅ Cache limpo! Fazendo reload COMPLETO...');
            
            // 💥 RELOAD SUPER AGRESSIVO
            // Aguarda um pouco para garantir que tudo foi limpo
            setTimeout(() => {
                // Tenta várias formas de reload agressivo
                if (window.location.reload) {
                    // Hard reload com cache bypass
                    window.location.reload(true);
                } else {
                    // Fallback: redireciona para a mesma URL com timestamp
                    const url = new URL(window.location.href);
                    url.searchParams.set('_t', Date.now());
                    window.location.href = url.toString();
                }
            }, 800);
            
            return false; // Não continua o carregamento
            
        } catch (error) {
            console.error('❌ Erro ao limpar cache:', error);
            // Em caso de erro, continua normalmente
            localStorage.setItem('app_version', currentVersion);
        }
    } else {
        // Armazena a versão atual se é a primeira vez ou versão igual
        localStorage.setItem('app_version', currentVersion);
        console.log('✅ Versão atual confirmada');
    }
    
    return true; // Continua o carregamento
}

// 🔄 VERIFICAÇÃO PERIÓDICA DE NOVA VERSÃO (opcional - para casos extremos)
function startPeriodicVersionCheck() {
    // Verifica se há nova versão a cada 5 minutos (apenas em produção)
    setInterval(async () => {
        try {
            console.log('🔍 Verificação periódica de versão...');
            
            // Faz uma requisição para buscar o arquivo bootstrap atual
            const response = await fetch(`flutter_bootstrap.js?t=${Date.now()}`);
            const content = await response.text();
            
            // Extrai a versão atual do servidor
            const versionMatch = content.match(/const appVersion = '([^']+)'/);
            if (versionMatch && versionMatch[1]) {
                const serverVersion = versionMatch[1];
                const localVersion = localStorage.getItem('app_version');
                
                console.log('🌐 Versão do servidor:', serverVersion);
                console.log('💾 Versão local:', localVersion);
                
                if (localVersion && serverVersion !== localVersion && serverVersion !== '20250723.123309.5df3e4') {
                    console.log('🚨 NOVA VERSÃO DISPONÍVEL! Recarregando automaticamente...');
                    
                    // Mostra notificação opcional para o usuário
                    if (window.confirm) {
                        const shouldReload = confirm('Nova versão disponível! Recarregar para obter as últimas funcionalidades?');
                        if (shouldReload) {
                            localStorage.setItem('app_version', serverVersion);
                            window.location.reload(true);
                        }
                    } else {
                        // Auto-reload se não pode mostrar confirm
                        localStorage.setItem('app_version', serverVersion);
                        window.location.reload(true);
                    }
                }
            }
        } catch (error) {
            console.log('⚠️ Erro na verificação periódica:', error);
        }
    }, 5 * 60 * 1000); // 5 minutos
}

// Verifica versão antes de carregar o Flutter
checkVersionAndClearCache().then(shouldContinue => {
    if (!shouldContinue) return; // Se limpou cache, vai recarregar a página
    
    _flutter.loader.load({
        // 🚀 CACHE BUSTING mais agressivo
        entrypointUrl: `main.dart.js?v=${appVersion}&t=${Date.now()}`,
        serviceWorker: {
            serviceWorkerVersion: serviceWorkerVersion,
        },
        onEntrypointLoaded: async function (engineInitializer) {
            try {
                console.log("Load entrypoint...");
                console.log("Entrypoint version:", appVersion);
                const appRunner = await engineInitializer.initializeEngine();
                removeLoader();
                await appRunner.runApp();
                
                // 🔄 Inicia verificação periódica após carregar o app
                startPeriodicVersionCheck();
                
                // initClarity();
            } catch (error) {
                console.error("Error on load entrypoint:", error);
            }
        }
    });
});

function removeLoader(){
    document.getElementsByClassName('loader')[0].remove();
}

// function initClarity(){
//     // (function(c,l,a,r,i,t,y){
//     //     c[a]=c[a]||function(){(c[a].q=c[a].q||[]).push(arguments)};
//     //     t=l.createElement(r);t.src="https://www.clarity.ms/tag/"+i;
//     //     y=l.getElementsByTagName(r)[0];y.parentNode.insertBefore(t,y);
//     // })(window, document, "clarity", "script", "qyf0uo7c2w");
//     // console.log("Clarity initialized after Flutter app loaded");
// }
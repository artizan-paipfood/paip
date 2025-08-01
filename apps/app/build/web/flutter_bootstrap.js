(()=>{var P=()=>navigator.vendor==="Google Inc."||navigator.agent==="Edg/",E=()=>typeof ImageDecoder>"u"?!1:P(),L=()=>typeof Intl.v8BreakIterator<"u"&&typeof Intl.Segmenter<"u",W=()=>{let n=[0,97,115,109,1,0,0,0,1,5,1,95,1,120,0];return WebAssembly.validate(new Uint8Array(n))},w={hasImageCodecs:E(),hasChromiumBreakIterators:L(),supportsWasmGC:W(),crossOriginIsolated:window.crossOriginIsolated};function l(...n){return new URL(C(...n),document.baseURI).toString()}function C(...n){return n.filter(t=>!!t).map((t,i)=>i===0?_(t):j(_(t))).filter(t=>t.length).join("/")}function j(n){let t=0;for(;t<n.length&&n.charAt(t)==="/";)t++;return n.substring(t)}function _(n){let t=n.length;for(;t>0&&n.charAt(t-1)==="/";)t--;return n.substring(0,t)}function T(n,t){return n.canvasKitBaseUrl?n.canvasKitBaseUrl:t.engineRevision&&!t.useLocalCanvasKit?C("https://www.gstatic.com/flutter-canvaskit",t.engineRevision):"canvaskit"}var v=class{constructor(){this._scriptLoaded=!1}setTrustedTypesPolicy(t){this._ttPolicy=t}async loadEntrypoint(t){let{entrypointUrl:i=l("main.dart.js"),onEntrypointLoaded:r,nonce:e}=t||{};return this._loadJSEntrypoint(i,r,e)}async load(t,i,r,e,a){a??=o=>{o.initializeEngine(r).then(c=>c.runApp())};let{entryPointBaseUrl:s}=r;if(t.compileTarget==="dart2wasm")return this._loadWasmEntrypoint(t,i,s,a);{let o=t.mainJsPath??"main.dart.js",c=l(s,o);return this._loadJSEntrypoint(c,a,e)}}didCreateEngineInitializer(t){typeof this._didCreateEngineInitializerResolve=="function"&&(this._didCreateEngineInitializerResolve(t),this._didCreateEngineInitializerResolve=null,delete _flutter.loader.didCreateEngineInitializer),typeof this._onEntrypointLoaded=="function"&&this._onEntrypointLoaded(t)}_loadJSEntrypoint(t,i,r){let e=typeof i=="function";if(!this._scriptLoaded){this._scriptLoaded=!0;let a=this._createScriptTag(t,r);if(e)console.debug("Injecting <script> tag. Using callback."),this._onEntrypointLoaded=i,document.head.append(a);else return new Promise((s,o)=>{console.debug("Injecting <script> tag. Using Promises. Use the callback approach instead!"),this._didCreateEngineInitializerResolve=s,a.addEventListener("error",o),document.head.append(a)})}}async _loadWasmEntrypoint(t,i,r,e){if(!this._scriptLoaded){this._scriptLoaded=!0,this._onEntrypointLoaded=e;let{mainWasmPath:a,jsSupportRuntimePath:s}=t,o=l(r,a),c=l(r,s);this._ttPolicy!=null&&(c=this._ttPolicy.createScriptURL(c));let d=(await import(c)).compileStreaming(fetch(o)),f;t.renderer==="skwasm"?f=(async()=>{let m=await i.skwasm;return window._flutter_skwasmInstance=m,{skwasm:m.wasmExports,skwasmWrapper:m,ffi:{memory:m.wasmMemory}}})():f=Promise.resolve({}),await(await(await d).instantiate(await f)).invokeMain()}}_createScriptTag(t,i){let r=document.createElement("script");r.type="application/javascript",i&&(r.nonce=i);let e=t;return this._ttPolicy!=null&&(e=this._ttPolicy.createScriptURL(t)),r.src=e,r}};async function I(n,t,i){if(t<0)return n;let r,e=new Promise((a,s)=>{r=setTimeout(()=>{s(new Error(`${i} took more than ${t}ms to resolve. Moving on.`,{cause:I}))},t)});return Promise.race([n,e]).finally(()=>{clearTimeout(r)})}var y=class{setTrustedTypesPolicy(t){this._ttPolicy=t}loadServiceWorker(t){if(!t)return console.debug("Null serviceWorker configuration. Skipping."),Promise.resolve();if(!("serviceWorker"in navigator)){let o="Service Worker API unavailable.";return window.isSecureContext||(o+=`
The current context is NOT secure.`,o+=`
Read more: https://developer.mozilla.org/en-US/docs/Web/Security/Secure_Contexts`),Promise.reject(new Error(o))}let{serviceWorkerVersion:i,serviceWorkerUrl:r=l(`flutter_service_worker.js?v=${i}`),timeoutMillis:e=4e3}=t,a=r;this._ttPolicy!=null&&(a=this._ttPolicy.createScriptURL(a));let s=navigator.serviceWorker.register(a).then(o=>this._getNewServiceWorker(o,i)).then(this._waitForServiceWorkerActivation);return I(s,e,"prepareServiceWorker")}async _getNewServiceWorker(t,i){if(!t.active&&(t.installing||t.waiting))return console.debug("Installing/Activating first service worker."),t.installing||t.waiting;if(t.active.scriptURL.endsWith(i))return console.debug("Loading from existing service worker."),t.active;{let r=await t.update();return console.debug("Updating service worker."),r.installing||r.waiting||r.active}}async _waitForServiceWorkerActivation(t){if(!t||t.state==="activated")if(t){console.debug("Service worker already active.");return}else throw new Error("Cannot activate a null service worker!");return new Promise((i,r)=>{t.addEventListener("statechange",()=>{t.state==="activated"&&(console.debug("Activated new service worker."),i())})})}};var g=class{constructor(t,i="flutter-js"){let r=t||[/\.js$/,/\.mjs$/];window.trustedTypes&&(this.policy=trustedTypes.createPolicy(i,{createScriptURL:function(e){if(e.startsWith("blob:"))return e;let a=new URL(e,window.location),s=a.pathname.split("/").pop();if(r.some(c=>c.test(s)))return a.toString();console.error("URL rejected by TrustedTypes policy",i,":",e,"(download prevented)")}}))}};var k=n=>{let t=WebAssembly.compileStreaming(fetch(n));return(i,r)=>((async()=>{let e=await t,a=await WebAssembly.instantiate(e,i);r(a,e)})(),{})};var b=(n,t,i,r)=>(window.flutterCanvasKitLoaded=(async()=>{if(window.flutterCanvasKit)return window.flutterCanvasKit;let e=i.hasChromiumBreakIterators&&i.hasImageCodecs;if(!e&&t.canvasKitVariant=="chromium")throw"Chromium CanvasKit variant specifically requested, but unsupported in this browser";let a=e&&t.canvasKitVariant!=="full",s=r;a&&(s=l(s,"chromium"));let o=l(s,"canvaskit.js");n.flutterTT.policy&&(o=n.flutterTT.policy.createScriptURL(o));let c=k(l(s,"canvaskit.wasm")),p=await import(o);return window.flutterCanvasKit=await p.default({instantiateWasm:c}),window.flutterCanvasKit})(),window.flutterCanvasKitLoaded);var U=async(n,t,i,r)=>{let e=i.crossOriginIsolated&&!t.forceSingleThreadedSkwasm?"skwasm":"skwasm_st",s=l(r,`${e}.js`);n.flutterTT.policy&&(s=n.flutterTT.policy.createScriptURL(s));let o=k(l(r,`${e}.wasm`));return await(await import(s)).default({instantiateWasm:o,mainScriptUrlOrBlob:new Blob([`import '${s}'`],{type:"application/javascript"})})};var S=class{async loadEntrypoint(t){let{serviceWorker:i,...r}=t||{},e=new g,a=new y;a.setTrustedTypesPolicy(e.policy),await a.loadServiceWorker(i).catch(o=>{console.warn("Exception while loading service worker:",o)});let s=new v;return s.setTrustedTypesPolicy(e.policy),this.didCreateEngineInitializer=s.didCreateEngineInitializer.bind(s),s.loadEntrypoint(r)}async load({serviceWorkerSettings:t,onEntrypointLoaded:i,nonce:r,config:e}={}){e??={};let a=_flutter.buildConfig;if(!a)throw"FlutterLoader.load requires _flutter.buildConfig to be set";let s=u=>{switch(u){case"skwasm":return w.hasChromiumBreakIterators&&w.hasImageCodecs&&w.supportsWasmGC;default:return!0}},o=(u,m)=>{switch(u.renderer){case"auto":return m=="canvaskit"||m=="html";default:return u.renderer==m}},c=u=>u.compileTarget==="dart2wasm"&&!w.supportsWasmGC||e.renderer&&!o(u,e.renderer)?!1:s(u.renderer),p=a.builds.find(c);if(!p)throw"FlutterLoader could not find a build compatible with configuration and environment.";let d={};d.flutterTT=new g,t&&(d.serviceWorkerLoader=new y,d.serviceWorkerLoader.setTrustedTypesPolicy(d.flutterTT.policy),await d.serviceWorkerLoader.loadServiceWorker(t).catch(u=>{console.warn("Exception while loading service worker:",u)}));let f=T(e,a);p.renderer==="canvaskit"?d.canvasKit=b(d,e,w,f):p.renderer==="skwasm"&&(d.skwasm=U(d,e,w,f));let h=new v;return h.setTrustedTypesPolicy(d.flutterTT.policy),this.didCreateEngineInitializer=h.didCreateEngineInitializer.bind(h),h.load(p,d,e,r,i)}};window._flutter||(window._flutter={});window._flutter.loader||(window._flutter.loader=new S);})();
//# sourceMappingURL=flutter.js.map

if (!window._flutter) {
  window._flutter = {};
}
_flutter.buildConfig = {"engineRevision":"cf56914b326edb0ccb123ffdc60f00060bd513fa","builds":[{"compileTarget":"dart2js","renderer":"canvaskit","mainJsPath":"main.dart.js"}]};


const appVersion = '20250801.161911.fab626' || '1.0.0'; 
const serviceWorkerVersion = '0527b86' || 'default-sw-version';

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
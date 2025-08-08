(()=>{var U=()=>navigator.vendor==="Google Inc."||navigator.agent==="Edg/",E=()=>typeof ImageDecoder>"u"?!1:U(),W=()=>typeof Intl.v8BreakIterator<"u"&&typeof Intl.Segmenter<"u",P=()=>{let s=[0,97,115,109,1,0,0,0,1,5,1,95,1,120,0];return WebAssembly.validate(new Uint8Array(s))},p={hasImageCodecs:E(),hasChromiumBreakIterators:W(),supportsWasmGC:P(),crossOriginIsolated:window.crossOriginIsolated};function l(...s){return new URL(_(...s),document.baseURI).toString()}function _(...s){return s.filter(e=>!!e).map((e,i)=>i===0?C(e):j(C(e))).filter(e=>e.length).join("/")}function j(s){let e=0;for(;e<s.length&&s.charAt(e)==="/";)e++;return s.substring(e)}function C(s){let e=s.length;for(;e>0&&s.charAt(e-1)==="/";)e--;return s.substring(0,e)}function L(s,e){return s.canvasKitBaseUrl?s.canvasKitBaseUrl:e.engineRevision&&!e.useLocalCanvasKit?_("https://www.gstatic.com/flutter-canvaskit",e.engineRevision):"canvaskit"}var h=class{constructor(){this._scriptLoaded=!1}setTrustedTypesPolicy(e){this._ttPolicy=e}async loadEntrypoint(e){let{entrypointUrl:i=l("main.dart.js"),onEntrypointLoaded:r,nonce:t}=e||{};return this._loadJSEntrypoint(i,r,t)}async load(e,i,r,t,n){n??=o=>{o.initializeEngine(r).then(c=>c.runApp())};let{entryPointBaseUrl:a}=r;if(e.compileTarget==="dart2wasm")return this._loadWasmEntrypoint(e,i,a,n);{let o=e.mainJsPath??"main.dart.js",c=l(a,o);return this._loadJSEntrypoint(c,n,t)}}didCreateEngineInitializer(e){typeof this._didCreateEngineInitializerResolve=="function"&&(this._didCreateEngineInitializerResolve(e),this._didCreateEngineInitializerResolve=null,delete _flutter.loader.didCreateEngineInitializer),typeof this._onEntrypointLoaded=="function"&&this._onEntrypointLoaded(e)}_loadJSEntrypoint(e,i,r){let t=typeof i=="function";if(!this._scriptLoaded){this._scriptLoaded=!0;let n=this._createScriptTag(e,r);if(t)console.debug("Injecting <script> tag. Using callback."),this._onEntrypointLoaded=i,document.head.append(n);else return new Promise((a,o)=>{console.debug("Injecting <script> tag. Using Promises. Use the callback approach instead!"),this._didCreateEngineInitializerResolve=a,n.addEventListener("error",o),document.head.append(n)})}}async _loadWasmEntrypoint(e,i,r,t){if(!this._scriptLoaded){this._scriptLoaded=!0,this._onEntrypointLoaded=t;let{mainWasmPath:n,jsSupportRuntimePath:a}=e,o=l(r,n),c=l(r,a);this._ttPolicy!=null&&(c=this._ttPolicy.createScriptURL(c));let d=(await import(c)).compileStreaming(fetch(o)),w;e.renderer==="skwasm"?w=(async()=>{let f=await i.skwasm;return window._flutter_skwasmInstance=f,{skwasm:f.wasmExports,skwasmWrapper:f,ffi:{memory:f.wasmMemory}}})():w=Promise.resolve({}),await(await(await d).instantiate(await w)).invokeMain()}}_createScriptTag(e,i){let r=document.createElement("script");r.type="application/javascript",i&&(r.nonce=i);let t=e;return this._ttPolicy!=null&&(t=this._ttPolicy.createScriptURL(e)),r.src=t,r}};async function T(s,e,i){if(e<0)return s;let r,t=new Promise((n,a)=>{r=setTimeout(()=>{a(new Error(`${i} took more than ${e}ms to resolve. Moving on.`,{cause:T}))},e)});return Promise.race([s,t]).finally(()=>{clearTimeout(r)})}var g=class{setTrustedTypesPolicy(e){this._ttPolicy=e}loadServiceWorker(e){if(!e)return console.debug("Null serviceWorker configuration. Skipping."),Promise.resolve();if(!("serviceWorker"in navigator)){let o="Service Worker API unavailable.";return window.isSecureContext||(o+=`
The current context is NOT secure.`,o+=`
Read more: https://developer.mozilla.org/en-US/docs/Web/Security/Secure_Contexts`),Promise.reject(new Error(o))}let{serviceWorkerVersion:i,serviceWorkerUrl:r=l(`flutter_service_worker.js?v=${i}`),timeoutMillis:t=4e3}=e,n=r;this._ttPolicy!=null&&(n=this._ttPolicy.createScriptURL(n));let a=navigator.serviceWorker.register(n).then(o=>this._getNewServiceWorker(o,i)).then(this._waitForServiceWorkerActivation);return T(a,t,"prepareServiceWorker")}async _getNewServiceWorker(e,i){if(!e.active&&(e.installing||e.waiting))return console.debug("Installing/Activating first service worker."),e.installing||e.waiting;if(e.active.scriptURL.endsWith(i))return console.debug("Loading from existing service worker."),e.active;{let r=await e.update();return console.debug("Updating service worker."),r.installing||r.waiting||r.active}}async _waitForServiceWorkerActivation(e){if(!e||e.state==="activated")if(e){console.debug("Service worker already active.");return}else throw new Error("Cannot activate a null service worker!");return new Promise((i,r)=>{e.addEventListener("statechange",()=>{e.state==="activated"&&(console.debug("Activated new service worker."),i())})})}};var y=class{constructor(e,i="flutter-js"){let r=e||[/\.js$/,/\.mjs$/];window.trustedTypes&&(this.policy=trustedTypes.createPolicy(i,{createScriptURL:function(t){if(t.startsWith("blob:"))return t;let n=new URL(t,window.location),a=n.pathname.split("/").pop();if(r.some(c=>c.test(a)))return n.toString();console.error("URL rejected by TrustedTypes policy",i,":",t,"(download prevented)")}}))}};var k=s=>{let e=WebAssembly.compileStreaming(fetch(s));return(i,r)=>((async()=>{let t=await e,n=await WebAssembly.instantiate(t,i);r(n,t)})(),{})};var I=(s,e,i,r)=>(window.flutterCanvasKitLoaded=(async()=>{if(window.flutterCanvasKit)return window.flutterCanvasKit;let t=i.hasChromiumBreakIterators&&i.hasImageCodecs;if(!t&&e.canvasKitVariant=="chromium")throw"Chromium CanvasKit variant specifically requested, but unsupported in this browser";let n=t&&e.canvasKitVariant!=="full",a=r;n&&(a=l(a,"chromium"));let o=l(a,"canvaskit.js");s.flutterTT.policy&&(o=s.flutterTT.policy.createScriptURL(o));let c=k(l(a,"canvaskit.wasm")),u=await import(o);return window.flutterCanvasKit=await u.default({instantiateWasm:c}),window.flutterCanvasKit})(),window.flutterCanvasKitLoaded);var b=async(s,e,i,r)=>{let t=l(r,"skwasm.js"),n=t;s.flutterTT.policy&&(n=s.flutterTT.policy.createScriptURL(n));let a=k(l(r,"skwasm.wasm"));return await(await import(n)).default({skwasmSingleThreaded:!i.crossOriginIsolated||e.forceSingleThreadedSkwasm,instantiateWasm:a,locateFile:(c,u)=>{if(c.endsWith(".ww.js")){let d=l(r,c);return URL.createObjectURL(new Blob([`
"use strict";

let eventListener;
eventListener = (message) => {
    const pendingMessages = [];
    const data = message.data;
    data["instantiateWasm"] = (info,receiveInstance) => {
        const instance = new WebAssembly.Instance(data["wasm"], info);
        return receiveInstance(instance, data["wasm"])
    };
    import(data.js).then(async (skwasm) => {
        await skwasm.default(data);

        removeEventListener("message", eventListener);
        for (const message of pendingMessages) {
            dispatchEvent(message);
        }
    });
    removeEventListener("message", eventListener);
    eventListener = (message) => {

        pendingMessages.push(message);
    };

    addEventListener("message", eventListener);
};
addEventListener("message", eventListener);
`],{type:"application/javascript"}))}return url},mainScriptUrlOrBlob:t})};var S=class{async loadEntrypoint(e){let{serviceWorker:i,...r}=e||{},t=new y,n=new g;n.setTrustedTypesPolicy(t.policy),await n.loadServiceWorker(i).catch(o=>{console.warn("Exception while loading service worker:",o)});let a=new h;return a.setTrustedTypesPolicy(t.policy),this.didCreateEngineInitializer=a.didCreateEngineInitializer.bind(a),a.loadEntrypoint(r)}async load({serviceWorkerSettings:e,onEntrypointLoaded:i,nonce:r,config:t}={}){t??={};let n=_flutter.buildConfig;if(!n)throw"FlutterLoader.load requires _flutter.buildConfig to be set";let a=m=>{switch(m){case"skwasm":return p.hasChromiumBreakIterators&&p.hasImageCodecs&&p.supportsWasmGC;default:return!0}},o=(m,f)=>m.renderer==f,c=m=>m.compileTarget==="dart2wasm"&&!p.supportsWasmGC||t.renderer&&!o(m,t.renderer)?!1:a(m.renderer),u=n.builds.find(c);if(!u)throw"FlutterLoader could not find a build compatible with configuration and environment.";let d={};d.flutterTT=new y,e&&(d.serviceWorkerLoader=new g,d.serviceWorkerLoader.setTrustedTypesPolicy(d.flutterTT.policy),await d.serviceWorkerLoader.loadServiceWorker(e).catch(m=>{console.warn("Exception while loading service worker:",m)}));let w=L(t,n);u.renderer==="canvaskit"?d.canvasKit=I(d,t,p,w):u.renderer==="skwasm"&&(d.skwasm=b(d,t,p,w));let v=new h;return v.setTrustedTypesPolicy(d.flutterTT.policy),this.didCreateEngineInitializer=v.didCreateEngineInitializer.bind(v),v.load(u,d,t,r,i)}};window._flutter||(window._flutter={});window._flutter.loader||(window._flutter.loader=new S);})();
//# sourceMappingURL=flutter.js.map

if (!window._flutter) {
  window._flutter = {};
}
_flutter.buildConfig = {"engineRevision":"ef0cd000916d64fa0c5d09cc809fa7ad244a5767","builds":[{"compileTarget":"dart2js","renderer":"canvaskit","mainJsPath":"main.dart.js"}]};


const appVersion = '20250808.182114.87ac6b' || '1.0.0'; 
const serviceWorkerVersion = '84e09c1' || 'default-sw-version';

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
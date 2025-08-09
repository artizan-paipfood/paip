// if (window.LogRocket) {
//     let sessionUrl = null;
//     let isRecording = false;

//     function initLogRocket() {
//         LogRocket.init('rdfq16/paip-food', {
//             shouldStart: false, 
//             shouldCaptureIP: false
//         });
//     }

//     function logRocketStartSession() {
//         if (!isRecording) {
//             LogRocket.start(); 
//             isRecording = true;

//             LogRocket.getSessionURL(url => {
//                 sessionUrl = url;
//                 console.log("LogRocket ativado. Sessão:", url);
//             });
//         } else {
//             console.log("A sessão já está ativa:", sessionUrl);
//         }
//     }

//     function logRocketIdentify(userId, userInfo ={}){
//         LogRocket.identify(userId, userInfo);
//     }

//     initLogRocket();

//     // Exporta para o escopo global
//     window.logRocketStartSession = logRocketStartSession;
//     window.logRocketIdentify = logRocketIdentify;
// } else {
//     console.error("LogRocket não carregado!");
// }

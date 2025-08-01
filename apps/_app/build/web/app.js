function alertMessage(text) {
    alert(text)
}
function callPixel(code) {
    const element = document.createElement('script');
    const noScript = document.createElement('noscript');
    const meta = document.createElement('meta');
    element.innerHTML = `
   !function(f,b,e,v,n,t,s)
   {if(f.fbq)return;n=f.fbq=function(){n.callMethod?
   n.callMethod.apply(n,arguments):n.queue.push(arguments)};
   if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
   n.queue=[];t=b.createElement(e);t.async=!0;
   t.src=v;s=b.getElementsByTagName(e)[0];
   s.parentNode.insertBefore(t,s)}(window, document,'script',
   'https://connect.facebook.net/en_US/fbevents.js');
   fbq('init', ${code});
   fbq('track', 'PageView');
   `;
    noScript.innerHTML = `<img height="1" width="1" style="display:none"
   src="https://www.facebook.com/tr?id=${code}&ev=PageView&noscript=1"
   />`;
    meta.name = "facebook-domain-verification";
    meta.content = "b4yey4nfq7mwjpi2oc3xj83pao8r4e";
    document.head.appendChild(element);
    document.head.appendChild(noScript);
    document.head.appendChild(meta);
}


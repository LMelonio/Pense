// Service worker simples: guarda o app para abrir sem internet (app, conteúdo baixado, termos e privacidade).
// - assets/ (nome com hash, nunca muda): cache primeiro;
// - o resto: rede primeiro, cache se falhar; só a navegação cai no index.html (um script nunca recebe HTML no lugar).
const CACHE = 'pense-app-v3';

self.addEventListener('install', (e) => {
  e.waitUntil(caches.open(CACHE).then((c) => c.addAll(['./', './index.html', './data/conteudo.json', './icone.svg', './termos.html', './privacidade.html', './tema.js'])).catch(() => undefined));
  self.skipWaiting();
});

// Apaga os caches de versões anteriores do app (o conteúdo baixado para estudar offline fica)
self.addEventListener('activate', (e) => e.waitUntil(
  caches.keys()
    .then((nomes) => Promise.all(nomes.filter((n) => n.startsWith('pense-app-') && n !== CACHE).map((n) => caches.delete(n))))
    .then(() => self.clients.claim())
));

function daRede(req) {
  return fetch(req).then((res) => {
    // Servidor com "SPA fallback" responde 200 com o index.html para um arquivo que não existe: isso não vai para o cache
    const htmlNoLugar = req.mode !== 'navigate' && (res.headers.get('content-type') || '').includes('text/html') && !new URL(req.url).pathname.endsWith('.html');
    if (res.ok && !htmlNoLugar) {
      const copia = res.clone();
      caches.open(CACHE).then((c) => c.put(req, copia));
    }
    return res;
  });
}

self.addEventListener('fetch', (e) => {
  const req = e.request;
  const url = new URL(req.url);
  if (req.method !== 'GET' || url.origin !== self.location.origin) return;
  if (url.pathname.includes('/assets/')) {
    e.respondWith(caches.match(req).then((r) => r || daRede(req)));
    return;
  }
  e.respondWith(
    daRede(req).catch(() => caches.match(req).then((r) => r || (req.mode === 'navigate' ? caches.match('./index.html') : Response.error())))
  );
});

self.addEventListener('install', e => {
  e.waitUntil(
    caches.open('static-cache').then(cache => {
      return cache.addAll(['/', '/index.html', '/styles.css']);
    })
  );
});

self.addEventListener('fetch', e => {
  e.respondWith(
    caches.match(e.request).then(response => {
      return response || fetch(e.request);
    })
  );
});
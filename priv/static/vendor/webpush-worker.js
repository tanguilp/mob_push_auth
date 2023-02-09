self.addEventListener('push', function(event) {
  data = event.data.json();

  const promiseChain = self.registration.showNotification(data.title, data);

  event.waitUntil(promiseChain);

});

self.addEventListener('notificationclick', function(event) {
  clients.openWindow(event.notification.data.url);
}, false);

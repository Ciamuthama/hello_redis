import consumer from "channels/consumer"

consumer.subscriptions.create("NotificationChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const notificationBox = document.getElementById('notification');
    if (notificationBox) {
      const notification = document.createElement('div');
      notification.classList.add('notification');
      notification.innerText = data.message;
      notificationBox.prepend(notification);
    }
  }
});

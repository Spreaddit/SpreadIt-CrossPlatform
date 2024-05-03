importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

firebase.initializeApp({
  apiKey: 'AIzaSyB-bMY0fyMC9XX3QZl_2z4AtjNSphf8pxE',
  appId: '1:932668103377:web:37af04c0d79ebfb6f7c3f0',
  messagingSenderId: '932668103377',
  projectId: 'spreadit-b8b53',
  authDomain: 'spreadit-b8b53.firebaseapp.com',
  storageBucket: 'spreadit-b8b53.appspot.com',
  measurementId: 'G-14L5Y6VJ0B',
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});

messaging.requestPermission().then(() => {
  console.log('Notification permission granted.');
}).catch((err) => {
  console.log('Unable to get permission to notify.', err);
  if (err.code === 'messaging/permission-blocked') {
    console.log('User blocked notifications.');
    // You can provide feedback to the user here, for example, showing a message or UI element.
  }
});
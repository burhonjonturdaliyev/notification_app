import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notification_app/main.dart';

class FirebaseApi {
  //creting instance of Firebase Messaging

  final _firebaseMessaging = FirebaseMessaging.instance;

  // function to initialize notification

  Future<void> initNotifications() async {
    // request permission from user (will promt user)
    await _firebaseMessaging.requestPermission();

    // fetch the FCM token for this device

    final fCMToken = await _firebaseMessaging.getToken();

    // print the token (normally you would send this to your server)

    print('Token $fCMToken');

    // initializa further settings for push notification
    initPushNotification();
  }

  // function to handle revievd message

  void handleMessage(RemoteMessage? message) {
    //   if the message is null, do nothing
    if (message == null) return;

    //  navigate to new screen when message is received and user taps notification

    navigatorKey.currentState?.pushNamed(
      '/notification_screen',
      arguments: message,
    );
  }

  // function to initialize foreground and background setting

  Future initPushNotification() async {
    // handle notification if the app was terminated and now opened

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    // attach event listeners for when a notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}

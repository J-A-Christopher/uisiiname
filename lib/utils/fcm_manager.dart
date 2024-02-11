import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:usiiname/main.dart';

class FCMManager {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<String?> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();

    print('My Token:$fcmToken');
    initPushNotifications();
    return fcmToken;
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState
        ?.pushNamed('/donation-requests', arguments: message);
  }

  Future initPushNotifications() async {
    //Handle notifications when the app was terminated and now opened
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

//Attach event listeners when a notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}

import 'package:firebase_messaging/firebase_messaging.dart';

class FCMManager {
 static Future<String?> getDeviceFcMToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    return fcmToken;
  }
}

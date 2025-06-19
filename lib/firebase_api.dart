import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class FirebaseApi{
  void handleMessage(RemoteMessage? message){
    if(message==null)return;
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('Payload: ${message.data}');
  }
  Future initPushNotifications() async{
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message){
      final notification = message.notification;
      if(notification==null)return;
      _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
              _androidChannel.name,
              channelDescription: _androidChannel.description,
              icon: '@drawable/ic_launcher'
            ),
          ),
          payload: jsonEncode(message.toMap()),
      );
    });
  }
  Future initLocalNotifications() async{
    const iOS = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(android: android, iOS: iOS);

    await _localNotifications.initialize(
        settings,
        onDidReceiveNotificationResponse: onReceiveNotificationResponse,
        onDidReceiveBackgroundNotificationResponse: onReceiveNotificationResponse,
      );
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel( 'high_importance channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications',
      importance: Importance.defaultImportance,
  );
  final _localNotifications = FlutterLocalNotificationsPlugin();
  Future<void> initNotifications() async{
    await _firebaseMessaging.requestPermission();
    final FCMToken = await _firebaseMessaging.getToken();
    debugPrint('token: $FCMToken');
    initPushNotifications();
    initLocalNotifications();
  }
}
Future<void> handleBackgroundMessage(RemoteMessage message) async{
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

void onReceiveNotificationResponse(NotificationResponse notificationResponse) async {
  print('onReceiveNotificationResponse');
  if (notificationResponse.payload == null)return;
  String? payload = notificationResponse.payload;
  print('onReceiveNotificationResponse: $payload');
  Map splitPayload = json.decode(payload!);
  //action = splitPayload["action"];

}
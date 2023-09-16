import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) {});

    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveBackgroundNotificationResponse: (details) {});
  }

  Future<void> simpleNotificationShow() async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('Channel_id', 'Channel_title',
            priority: Priority.high,
            importance: Importance.max,
            icon: '@mipmap/ic_launcher',
            channelShowBadge: true,
            largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'));

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    print(".............................");
    // print(title);
    // return notificationsPlugin.show(id, title, body, await notificationDetails);
    return notificationsPlugin.show(
        0, "Notification", "Hello user", notificationDetails);
  }
}

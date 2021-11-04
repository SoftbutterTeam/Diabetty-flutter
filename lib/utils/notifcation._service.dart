import 'dart:io';

import 'package:diabetty/ui/screens/teams/common.mixin.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class ReceivedNotification {
  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });

  final int id;
  final String title;
  final String body;
  final String payload;

  action() async {
    //... navigate to the day plan screnen
  }
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

const MethodChannel platform =
    MethodChannel('dexterx.dev/flutter_local_notifications_example');

String selectedNotificationPayload;

Future<void> _configureLocalTimeZone() async {
  if (kIsWeb || Platform.isLinux) {
    return;
  }
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}

class NotificationService with CommonMixins {
  void init() async {
    // * Notifications Config ---------------------------------------
    await _configureLocalTimeZone();
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestSoundPermission: true,
            requestBadgePermission: true,
            requestAlertPermission: true,
            onDidReceiveLocalNotification:
                (int id, String title, String body, String payload) async {});

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      if (payload == null)
        return print('notifcation payload: ' + payload);
      else
        print('notifcation payload: ' + payload);
      /*  await Navigator.pushNamed(context, today);
      Provider.of<DayPlanManager>(context, listen: false).currentDateStamp = payload.;    
    */
    });
    // * End of Notifications Config ---------------------------------------
  }

  scheduleNotfication(
      {int id, String title, String body, DateTime scheduledDate}) async {
    var androidPlatformChannelSpecs = AndroidNotificationDetails(
      'diab_01',
      'diab_01',
      'Channel for medication notifications',
      icon: 'app_icon',
      sound: null,
      largeIcon: null,
    ); //* can add the sound and largeIcon DrawableResourceAndroidBitmap('app-icon')

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
      sound: null,
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      threadIdentifier: scheduledDate.toString(),
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecs,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();

    try {
      print('notificationTest05: ' + pendingNotificationRequests?.first?.body);
    } catch (e) {}
  }

  clearScheduledNotfications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

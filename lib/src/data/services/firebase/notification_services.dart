// import 'dart:developer';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await NotificationServices.instance.setupFlutterNotifications();
//   await NotificationServices.instance.showNotification(message);
// }

// class NotificationServices {
//   NotificationServices._();
//   static final NotificationServices instance = NotificationServices._();

//   final _messaging = FirebaseMessaging.instance;
//   final _localnotifications = FlutterLocalNotificationsPlugin();
//   bool isFlutterlocalnotificationsInitialized = false;

//   Future<void> initialize() async {
//     try {
//       FirebaseMessaging.onBackgroundMessage(
//           _firebaseMessagingBackgroundHandler);
//       await _requestPermission();
//       await _setupMessageHandlers();
//     } catch (e) {
//       log("Error in Notification services():$e");
//     }
//   }

//   Future<void> _requestPermission() async {
//     final settings = await _messaging.requestPermission(
//         alert: true,
//         badge: true,
//         sound: true,
//         provisional: false,
//         announcement: false,
//         carPlay: false,
//         criticalAlert: false);

//     print("permission status:${settings.authorizationStatus}");
//     final token = await _messaging.getToken();
//     print("token :$token");
//   }

//   Future<void> setupFlutterNotifications() async {
//     if (isFlutterlocalnotificationsInitialized) {
//       return;
//     }
//     //android setup;

//     const channel = AndroidNotificationChannel(
//         'high_importance_channel', 'High Importance Notifications',
//         description: 'This channel is used for important notifications',
//         importance: Importance.high);

//     await _localnotifications
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);

//     const initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     final initializationSettings =
//         InitializationSettings(android: initializationSettingsAndroid);

//     await _localnotifications.initialize(initializationSettings,
//         onDidReceiveNotificationResponse: (detail) {});

//     isFlutterlocalnotificationsInitialized = true;
//   }

//   Future<void> showNotification(RemoteMessage message) async {
//     RemoteNotification? notification = message.notification;
//     AndroidNotification? android = message.notification?.android;

//     if (notification != null && android != null) {
//       await _localnotifications.show(
//         notification.hashCode,
//         notification.title,
//         notification.body,
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//               'high_importance_channel', 'High Importance Notifications',
//               channelDescription:
//                   'This channel is used for important notifications',
//               importance: Importance.high,
//               priority: Priority.high,
//               icon: '@mipmap/ic_launcher'),
//         ),
//         payload: message.data.toString(),
//       );
//     }
//   }

//   Future<void> _setupMessageHandlers() async {
//     //foreground
//     FirebaseMessaging.onMessage.listen((message) {
//       showNotification(message);
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen(
//       (onDat) {
//         _handleBackgroundMessage(onDat);
//       },
//       onError: (err) {},
//       onDone: () {},
//     );

//     final initialMessage = await _messaging.getInitialMessage();
//     if (initialMessage != null) {
//       _handleBackgroundMessage(initialMessage);
//     }
//   }

//   void _handleBackgroundMessage(RemoteMessage message) {
//     if (message.data['type'] == 'chat') {}
//   }
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sixth_exam/data/local_db/locak_darabase.dart';
import 'package:sixth_exam/data/model/notification_model.dart';
import 'app/app.dart';
import 'app/bloc_observer.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  List a = [];
  var result = message.data.values.map((e) => e);

  await LocalDatabase.addNotification(NotificationModel(
      title: message.notification!.title.toString(),
      date: DateTime.now().toString(),
      body: result.first,
      image: result.first));
}

Future multipleRegistreshion() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.subscribeToTopic("news");
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  multipleRegistreshion();
  Bloc.observer = AppBlocObserver();

  runApp(App());
}

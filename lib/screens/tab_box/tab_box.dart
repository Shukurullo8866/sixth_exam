import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sixth_exam/cubit/connectivity/connectivity_cubit.dart';
import 'package:sixth_exam/data/model/notification_model.dart';
import 'package:sixth_exam/screens/tab_box/single_cubit_screen/single_cubit_screen.dart';
import 'package:sixth_exam/servise/local_notification.dart';

import '../../cubit/connectivity/connectivity_state.dart';
import '../../data/local_db/locak_darabase.dart';
import '../noInternet_screen/noInternet_screen.dart';
import 'local_nitification/local_notification_screen.dart';
import 'multi_cubit_screen/multi_state_screen.dart';
import 'notification_screen/notification_page.dart';

class TabBox extends StatefulWidget {
  const TabBox({super.key});

  @override
  State<TabBox> createState() => _TabBoxState();
}

_init() async {}

class _TabBoxState extends State<TabBox> {
  handleFirebaseNotificationMessages() async {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        if (message.notification != null) {
          await LocalDatabase.addNotification(
            NotificationModel(
                title: message.notification!.title.toString(),
                date: DateTime.now().toString(),
                body: message.notification!.body.toString(),
                image: "https://picsum.photos/200/300"),
          );
          var id = message.messageId.toString();

          LocalNotificationService.localNotificationService
              .showNotificationByFirebase(
            id: int.parse(id),
          );
        }
      },
    );
  }

  int currentPage = 0;
  @override
  void initState() {
    handleFirebaseNotificationMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List pages = [
      const SingleCubitPage(),
      const MultiCubitPage(),
      const NotificationsPage(),
      const LocalSmsPage()
    ];
    return BlocListener<ConnectivityCubit, ConnectivityState>(
      listener: (context, state) {
        if (state.connectivityResult == ConnectivityResult.none) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const NoInternetScreen(
                voidCallback: _init,
              ),
            ),
          );
        }
      },
      child: Scaffold(
        body: pages[currentPage],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentPage,
          onTap: (value) {
            currentPage = value;
            setState(() {});
          },
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.abc_sharp), label: "A"),
            BottomNavigationBarItem(icon: Icon(Icons.abc_rounded), label: "B"),
            BottomNavigationBarItem(icon: Icon(Icons.abc_outlined), label: "D"),
            BottomNavigationBarItem(icon: Icon(Icons.abc), label: "C"),
          ],
        ),
      ),
    );
  }
}

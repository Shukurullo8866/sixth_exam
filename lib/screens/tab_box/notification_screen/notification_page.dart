import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubit/notification_cubit/notification_state_cubit.dart';
import '../../../cubit/notification_cubit/notification_state_strate.dart';
import '../../../data/local_db/locak_darabase.dart';
import '../../../data/servise/notificationApi.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NotificationCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white60,
          elevation: 0,
          actions: [
            IconButton(
              color: Colors.red,
              onPressed: () {
                LocalDatabase.deleteAllNotification();
              },
              icon: const Icon(Icons.delete),
            ),
            TextButton(
                onPressed: () {
                  NotificationApiService.sendNotificationToAll("my_news");
                },
                child: const Icon(Icons.browser_updated_sharp)),
          ],
          iconTheme: const IconThemeData(color: Colors.blue),
          title: const Text(('notifications'),
              style: TextStyle(fontSize: 24, color: Colors.black)),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: BlocBuilder<NotificationCubit, NotificationState>(
            builder: (context, state) {
              if (state is LoadNotificationProgress) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LoadNotificationSuccess) {
                return Column(
                  children: [
                    ...List.generate(
                      state.notifications.length,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: Column(
                              children: [
                                Text(state.notifications[index].title),
                                Text(state.notifications[index].body),
                                Text(state.notifications[index].date),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  const SizedBox(height: 10),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

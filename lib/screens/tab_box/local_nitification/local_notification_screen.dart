import 'package:flutter/material.dart';
import '../../../servise/local_notification.dart';

class LocalSmsPage extends StatefulWidget {
  const LocalSmsPage({Key? key}) : super(key: key);

  @override
  State<LocalSmsPage> createState() => _LocalSmsPageState();
}

class _LocalSmsPageState extends State<LocalSmsPage> {
  TextEditingController name2Controller = TextEditingController();

  TextEditingController nameController = TextEditingController();

  int currentId = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Local Notification"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'What do people call you?',
                labelText: 'Name *',
              ),
              onSaved: (String? value) {

              },
              validator: (String? value) {
                return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
              },
            ),
            TextButton(
              onPressed: () {
                currentId++;
                LocalNotificationService.localNotificationService
                    .showNotification(id: currentId, name: nameController.text, desckiptio: 'send Sms1 ');
              },
              child: const Text("SIMPLE Notification Send"),
            ),
            TextFormField(
              controller: name2Controller,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'What do people call you?',
                labelText: 'Name *',
              ),
              onSaved: (String? value) {

              },
              validator: (String? value) {
                return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
              },
            ),
            TextButton(
              onPressed: () {
                currentId++;
                LocalNotificationService.localNotificationService
                    .showNotification(id: currentId, name: name2Controller.text, desckiptio: 'Simple 2 Sms');
              },
              child: const Text("Send Sms 2"),
            ),
            const SizedBox(height: 30),
            TextButton(
              onPressed: () {
                currentId++;
                LocalNotificationService.localNotificationService
                    .scheduleNotification(
                  id: currentId,
                  delayedTime: 3,
                );
              },
              child: const Text("SCHEDULED NOTIFICATION "),
            ),
            TextButton(
              onPressed: () {
                currentId++;
                LocalNotificationService.localNotificationService
                    .showPeriodically(id: currentId);
              },
              child: const Text("PERIODIC NOTIFICATION EVERY MINUTE"),
            ),
            TextButton(
              onPressed: () {
                currentId++;
                LocalNotificationService.localNotificationService
                    .showNotificationByFirebase();
              },
              child: const Text("Firebase notification"),
            ),
            const Expanded(child: SizedBox()),
            TextButton(
                onPressed: () {
                  LocalNotificationService.localNotificationService
                      .cancelAllNotifications();
                },
                child: const Text("Cancel All Notifications")),
            TextButton(
                onPressed: () {
                  LocalNotificationService.localNotificationService
                      .cancelNotificationById(currentId);
                },
                child: const Text("Cancel Notification By id")),
          ],
        ),
      ),
    );
  }
}
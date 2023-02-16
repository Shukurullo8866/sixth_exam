import 'package:sixth_exam/data/model/notification_model.dart';

abstract class CachNotificationState {}

class NotificationInitial extends CachNotificationState {}

class LoadInProgress extends CachNotificationState {}

class NotificationLoadSuccess extends CachNotificationState {
  NotificationLoadSuccess({required this.notification});

  final List<NotificationModel> notification;
}

class NotificationFailure extends CachNotificationState {
  final String error;
  NotificationFailure({required this.error});
}

class NotificationFromCache extends CachNotificationState {
  NotificationFromCache({required this.notification});

  final List<NotificationModel> notification;
}
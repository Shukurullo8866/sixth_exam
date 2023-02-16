import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/local_db/locak_darabase.dart';
import '../../data/model/notification_model.dart';
import 'notification_state_strate.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(InitialNotificationState()) {
    _getAllNotifications();
  }

  _getAllNotifications() {
    emit(LoadNotificationProgress());
    LocalDatabase.getAllNotifications()
        .asStream()
        .listen((List<NotificationModel> notifications) {
      emit(LoadNotificationSuccess(notifications: notifications));
    });
  }
}
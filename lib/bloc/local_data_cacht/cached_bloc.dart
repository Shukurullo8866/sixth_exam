import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sixth_exam/data/model/notification_model.dart';
import 'package:sixth_exam/data/repositories/notification_repo.dart';

import '../../data/model/myResponse.dart';
import 'cached_state.dart';
import 'ceched_event.dart';

class MessegeBloc extends Bloc<NotificationEvent, CachNotificationState > {
  MessegeBloc({required this.notificationRepository}) : super((NotificationInitial())) {
    on<getMessenger>(_fetchNotification);
  }

  final NotificationRepository notificationRepository;

  _fetchNotification(getMessenger event, Emitter<CachNotificationState> emit) async {
    emit(LoadInProgress());

    MyResponse myResponse =
        (await notificationRepository.getAllCachedNotificatio()) as MyResponse;

    {
      List<NotificationModel> news = myResponse.data as List<NotificationModel>;
      emit(NotificationLoadSuccess(notification: news));
      await _updateCachedNotification(news);

      print("ERROR USERS: ${myResponse.error}");
      List<NotificationModel> notifications =
          await notificationRepository.getAllCachedNotificatio();
      print(notifications);
      if (notifications.isNotEmpty) {
        emit(NotificationFromCache(notification: news));
      } else {
        emit(NotificationLoadSuccess(notification: news));
      }
    }
  }

  _updateCachedNotification(List<NotificationModel> notification) async {
    int deletedCount = await notificationRepository.deleteCachedNotification();
    print("O'CHIRILGANLAR SONI:$deletedCount");
    for (var massege in notification) {
      await notificationRepository.insertCountryToDb(massege);
    }
  }
}

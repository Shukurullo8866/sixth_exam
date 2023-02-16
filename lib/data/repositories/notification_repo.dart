import '../local_db/locak_darabase.dart';
import '../model/notification_model.dart';

class NotificationRepository {
  NotificationRepository();

  Future<NotificationModel> insertCountryToDb(
          NotificationModel notificationModel) =>
      LocalDatabase.addNotification(notificationModel);

  Future<List<NotificationModel>> getAllCachedNotificatio() =>
      LocalDatabase.getAllNotifications();

  Future<int> deleteCachedNotification() =>
      LocalDatabase.deleteAllNotification();
}

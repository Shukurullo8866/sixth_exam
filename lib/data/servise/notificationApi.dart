import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:http/http.dart';

class NotificationApiService {
  static Future<String> sendNotificationToAll(String topicName) async {
    String key =
        "key=AAAAB2QBBDI:APA91bHkxdEAbdaouzqIu8IQYfbSUI8cOCiHr0ZgmFMOpUIJMNgwB3wwRdfhNrt_8GiDAsZdCXhgaB5yOJ1QpbUbpVgxDQbbja5Befpix3VmlXHKos2v_0s6QWZD17CQes0tXorM_cW0";

    Map<String, dynamic> body = {
      "to": "/topics/$topicName",
      "notification": {
        "title": "Notification keled",
        "body": "Bu notification "
      },
      "data": {
        "name": "titlar ",
        "job": "Programmer",
      }
    };

    Uri uri = Uri.parse("https://fcm.googleapis.com/fcm/send");
    try {
      Response response = await https.post(
        uri,
        headers: {
          "Authorization": key,
          "Content-Type": "application/json",
        },
        body: json.encode(body),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["message_id"].toString();
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

import 'package:dio/dio.dart';

import '../model/code_model.dart';
import '../model/myResponse.dart';
import 'api_cliants.dart';

// class ApiService extends ApiClient {
//   Future<MyResponse> getAllCode() async {
//     MyResponse myResponse=MyResponse(error: "");
//     try {
//       print("Keldi");
//       Response response =
//       await dio.get("${dio.options.baseUrl}/user_cards");
//       if (response.statusCode == 200) {
//         myResponse.data = response.data.map((e) => AutoModel.fromJson(e)).toList();
//         print("Respons zzz");
//       }
//     } catch (e) {
//       myResponse.error = e.toString();
//       print(e.toString());
//     }
//     return myResponse;
//   }
// }
class ApiService extends ApiClient {
  Future<MyResponse> getAllCode() async {
    MyResponse myResponse = MyResponse(error: "");
    try {
      Response response =
          await dio.get("https://kontests.net/api/v1/codeforces");

      if (response.statusCode == 200) {
        myResponse.data =
            (response.data as List).map((e) => AutoModel.fromJson(e)).toList();
      }
    } catch (error) {
      myResponse.error = error.toString();
    }
    return myResponse;
  }
}

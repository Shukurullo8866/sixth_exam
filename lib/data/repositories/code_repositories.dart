import '../model/myResponse.dart';
import '../servise/api_servise.dart';

class CodeRepositories {
  CodeRepositories({required this.apiService});

  final ApiService apiService;

  Future<MyResponse> getAllCode() => apiService.getAllCode();
}

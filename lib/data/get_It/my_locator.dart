
import 'package:get_it/get_it.dart';
import 'package:sixth_exam/data/repositories/code_repositories.dart';
import 'package:sixth_exam/data/servise/api_servise.dart';

final myLocator = GetIt.instance;

setUpLocator(){
  var apiServise = ApiService();
  myLocator.registerLazySingleton(() => CodeRepositories(apiService: apiServise));
  myLocator.registerLazySingleton(() => ApiService());
}
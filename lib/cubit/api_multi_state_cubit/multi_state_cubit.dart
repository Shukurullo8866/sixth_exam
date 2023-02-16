import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sixth_exam/data/repositories/code_repositories.dart';

import '../../data/model/myResponse.dart';


part 'multi_state_state.dart';

class MultiStateCubit extends Cubit<MultiStateStateCubit> {
  MultiStateCubit({required this.codeRepositories}) : super(MultiStateInitial()){
    getData();
  }
  CodeRepositories codeRepositories;

  getData() async {
    emit(GettingDataInProgres());
    MyResponse myResponse = await codeRepositories.getAllCode();
    if(myResponse.error==""){
      emit(GettingDataInSucces(cards: myResponse.data));
    }else{
      emit(GettingDataInFailurys(error: myResponse.error));
    }
  }
}
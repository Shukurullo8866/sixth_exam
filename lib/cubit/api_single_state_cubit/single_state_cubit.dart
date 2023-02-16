import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/model/myResponse.dart';
import '../../data/repositories/code_repositories.dart';

part 'single_state_state.dart';

class SingleStateCubit extends Cubit<CubitSingleState> {
  SingleStateCubit({required this.codeRepository}) : super(CubitSingleState()) {
    getData();
  }

  CodeRepositories codeRepository;

  getData() async {
    emit(CubitSingleState(status: Status.LOADING));
    MyResponse myResponse = await codeRepository.getAllCode();
    if (myResponse.error == "") {
      emit(state.copyWith(codes: myResponse.data, status: Status.SUCCESS));
    } else {
      emit(state.copyWith(error: myResponse.error, status: Status.ERROR));
    }
  }
}

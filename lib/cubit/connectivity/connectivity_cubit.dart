

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sixth_exam/cubit/connectivity/connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState>{
  ConnectivityCubit():super(ConnectivityState(connectivityResult: ConnectivityResult.mobile)){
    chekInternet();
  }
  final Connectivity _connectivity = Connectivity();

  chekInternet(){
    initConnectivity;
    _connectivity.onConnectivityChanged.listen((event) {
      emit(state.copyWith(connectivityResult: event));
    });
  }
  Future<void> initConnectivity() async{
    ConnectivityResult result;
    try{
      result = await _connectivity.checkConnectivity();
    }on PlatformException{
      return;
    }
    emit(state.copyWith(connectivityResult: result));
  }
}
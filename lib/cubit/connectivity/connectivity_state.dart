
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class ConnectivityState extends Equatable{
  ConnectivityState({required this.connectivityResult});

  final ConnectivityResult connectivityResult;

  ConnectivityState copyWith({ConnectivityResult? connectivityResult}) =>
    ConnectivityState(connectivityResult: connectivityResult ?? this.connectivityResult);

  @override
  List<Object> get props => [connectivityResult];
}
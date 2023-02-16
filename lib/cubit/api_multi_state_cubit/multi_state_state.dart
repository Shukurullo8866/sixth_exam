part of 'multi_state_cubit.dart';

@immutable
abstract class MultiStateStateCubit {}

class MultiStateInitial extends MultiStateStateCubit {}

class GettingDataInProgres extends MultiStateStateCubit{}
class GettingDataInFailurys extends MultiStateStateCubit{
  String error;

  GettingDataInFailurys({required this.error});

}
class GettingDataInSucces extends MultiStateStateCubit {
  List cards;

  GettingDataInSucces({required this.cards});
}
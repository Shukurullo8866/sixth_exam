part of 'single_state_cubit.dart';

class CubitSingleState extends Equatable {
  Status? status;
  String? error;
  List? codes;

  CubitSingleState({
    this.status,
    this.error,
    this.codes,
  });

  CubitSingleState copyWith({
    Status? status,
    String? error,
    List? codes,
  }) {
    return CubitSingleState(
        error: error ?? this.error,
        codes: codes ?? this.codes,
        status: status ?? this.status);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, error, codes];
}
enum Status { CODING, BEFORE, LOADING,SUCCESS,ERROR }

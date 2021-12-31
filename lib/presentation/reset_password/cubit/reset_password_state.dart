part of 'reset_password_cubit.dart';

class ResetPasswordState extends Equatable {
  final String verificationCode;
  const ResetPasswordState({
    this.verificationCode = "",
  });

  ResetPasswordState copyWith({
    String? verificationCode,
  }){
    return ResetPasswordState(verificationCode: verificationCode ?? this.verificationCode);
  }
  @override
  List<Object> get props => [verificationCode];
}

class ResetPasswordInitial extends ResetPasswordState {}

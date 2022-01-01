part of 'new_password_bloc.dart';

@immutable
abstract class NewPasswordEvent {}

class NewPasswordChanged extends NewPasswordEvent {
  final String? newPassword;

  NewPasswordChanged({this.newPassword});
}

class ConfirmPasswordChanged extends NewPasswordEvent {
  final String? confirmPassword;

  ConfirmPasswordChanged({this.confirmPassword});
}

class IsObscureTextChanged extends NewPasswordEvent {
  final bool? isObscureText;

  IsObscureTextChanged({this.isObscureText});
}

class NewPasswordSubmitted extends NewPasswordEvent {}

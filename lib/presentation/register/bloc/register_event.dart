part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}


class RegisterNameChanged extends RegisterEvent {
  final String? name;

  RegisterNameChanged({this.name});
}

class RegisterEmailChanged extends RegisterEvent {
  final String? email;

  RegisterEmailChanged({this.email});
}

class RegisterPasswordChanged extends RegisterEvent {
  final String? password;

  RegisterPasswordChanged({this.password});
}

class RegisterSubmitted extends RegisterEvent {
  
}

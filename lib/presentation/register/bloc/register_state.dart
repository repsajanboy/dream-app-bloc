part of 'register_bloc.dart';

class RegisterState {
  final String name;
  bool get isNameNotEmpty => name.isNotEmpty;
  final String email;
  final String password;
  bool get isValidPassword => password.length > 6;
  final FormSubmissionStatus formStatus;

  RegisterState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  RegisterState copyWith({
    String? name,
    String? email,
    String? password,
    FormSubmissionStatus? formStatus,
  }) {
    return RegisterState(
      name: name ?? this.name,
      email: email ?? this.email,
      password:  password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}

part of 'login_bloc.dart';

class LoginState {
  final String email;
  final String password;
  bool get isValidPassword => password.length > 6;
  bool isObscureText;
  final FormSubmissionStatus formStatus;

  LoginState({
    this.email = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
    this.isObscureText = false,
  });

  LoginState copyWith({
    String? email,
    String? password,
    FormSubmissionStatus? formStatus,
    bool? isObscureText,
  }) {
    return LoginState (
      email: email ?? this.email,
      password:  password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
      isObscureText: isObscureText ?? this.isObscureText,
    );
  }
}

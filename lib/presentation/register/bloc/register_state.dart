part of 'register_bloc.dart';

class RegisterState {
  final String firstName;
  bool get isFirstNameNotEmpty => firstName.isNotEmpty;
  final String lastName;
  bool get isLastNameNotEmpty => lastName.isNotEmpty;
  final String email;
  final String password;
  bool get isValidPassword => password.length > 6;
  bool isObscureText;
  final FormSubmissionStatus formStatus;

  RegisterState({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
    this.isObscureText = false,
  });

  RegisterState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    FormSubmissionStatus? formStatus,
    bool? isObscureText,
  }) {
    return RegisterState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password:  password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
      isObscureText: isObscureText ?? this.isObscureText,
    );
  }
}

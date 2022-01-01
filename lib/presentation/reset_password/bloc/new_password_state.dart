part of 'new_password_bloc.dart';

class NewPasswordState {
  final String newPassword;
  final String confirmPassword;
  final FormSubmissionStatus formStatus;
  bool isObscureText;
  bool get isValidPassword => newPassword.length > 6;
  bool get isMatchPassword => newPassword == confirmPassword;

  NewPasswordState({
    this.newPassword = '',
    this.confirmPassword = '',
    this.formStatus = const InitialFormStatus(),
    this.isObscureText = false,
  });

  NewPasswordState copyWith({
    String? newPassword,
    String? confirmPassword,
    FormSubmissionStatus? formStatus,
    bool? isObscureText,
  }) {
    return NewPasswordState(
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      formStatus: formStatus ?? this.formStatus,
      isObscureText: isObscureText ?? this.isObscureText,
    );
  }
}

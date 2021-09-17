part of 'profile_setting_bloc.dart';

class ProfileSettingState extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final bool someDataChanged;
  final FormSubmissionStatus formStatus;

  const ProfileSettingState({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.someDataChanged = false,
    this.formStatus = const InitialFormStatus(),
  });

  ProfileSettingState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    bool? someDataChanged,
    FormSubmissionStatus? formStatus
  }) {
    return ProfileSettingState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      someDataChanged: someDataChanged ?? this.someDataChanged,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  @override
  String toString() {
    return '''ProfileState''';
  }

  @override
  List<Object> get props => [firstName, lastName, email, formStatus, someDataChanged];
}

class ProfileSettingInitial extends ProfileSettingState {}

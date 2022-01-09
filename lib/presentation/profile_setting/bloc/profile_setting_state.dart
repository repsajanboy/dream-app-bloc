part of 'profile_setting_bloc.dart';

class ProfileSettingState extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final bool someDataChanged;
  final FormSubmissionStatus formStatus;
  final bool isDailyEnabled;
  final TimeOfDay timeOfDay;

  const ProfileSettingState({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.someDataChanged = false,
    this.formStatus = const InitialFormStatus(),
    this.isDailyEnabled = false,
    this.timeOfDay = const TimeOfDay(hour: 8, minute: 0),
  });
  ProfileSettingState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    bool? someDataChanged,
    FormSubmissionStatus? formStatus,
    bool? isDailyEnabled,
    TimeOfDay? timeOfDay,
  }) {
    return ProfileSettingState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      someDataChanged: someDataChanged ?? this.someDataChanged,
      formStatus: formStatus ?? this.formStatus,
      isDailyEnabled: isDailyEnabled ?? this.isDailyEnabled,
      timeOfDay: timeOfDay ?? this.timeOfDay,
    );
  }

  @override
  String toString() {
    return '''ProfileState''';
  }

  @override
  List<Object> get props => [
        firstName,
        lastName,
        email,
        formStatus,
        someDataChanged,
        isDailyEnabled,
        timeOfDay
      ];
}

class ProfileSettingInitial extends ProfileSettingState {}

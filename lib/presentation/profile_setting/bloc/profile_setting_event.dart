part of 'profile_setting_bloc.dart';

abstract class ProfileSettingEvent extends Equatable {
  const ProfileSettingEvent();

  @override
  List<Object> get props => [];
}

class ProfileSettingEdit extends ProfileSettingEvent {
  final User? user;

  const ProfileSettingEdit({this.user});
}

class ProfileFirstNameChanged extends ProfileSettingEvent {
  final String? firstName;

  const ProfileFirstNameChanged({this.firstName});
}

class ProfileLastNameChanged extends ProfileSettingEvent {
  final String? lastName;

  const ProfileLastNameChanged({this.lastName});
}

class ProfileEmailChanged extends ProfileSettingEvent {
  final String? email;

  const ProfileEmailChanged({this.email});
}

class ProfileSaveChanges extends ProfileSettingEvent {}

class ProfileEditDataChanged extends ProfileSettingEvent {
  final bool? someDataChanged;

  const ProfileEditDataChanged({this.someDataChanged});
}

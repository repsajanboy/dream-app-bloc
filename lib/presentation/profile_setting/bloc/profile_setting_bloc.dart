import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dream_app_bloc/data/user/user.dart';
import 'package:dream_app_bloc/repositories/user_repository.dart';
import 'package:dream_app_bloc/utils/form_submission_status.dart';
import 'package:equatable/equatable.dart';

part 'profile_setting_event.dart';
part 'profile_setting_state.dart';

class ProfileSettingBloc
    extends Bloc<ProfileSettingEvent, ProfileSettingState> {
  ProfileSettingBloc({required this.userRepository})
      : super(ProfileSettingInitial());

  final UserRepository userRepository;

  @override
  Stream<ProfileSettingState> mapEventToState(
    ProfileSettingEvent event,
  ) async* {
    if (event is ProfileSettingEdit) {
      yield await _mapProfileEditToState(event, state);
    } else if (event is ProfileFirstNameChanged) {
      yield state.copyWith(firstName: event.firstName);
    } else if (event is ProfileLastNameChanged) {
      yield state.copyWith(lastName: event.lastName);
    } else if (event is ProfileEmailChanged) {
      yield state.copyWith(email: event.email);
    } else if (event is ProfileSaveChanges) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        final userDetails = {
          "firstName": state.firstName,
          "lastName": state.lastName,
          "email": state.email,
          "updateDate": DateTime.now().toIso8601String(),
        };
        await userRepository.updateProfileDetails(userDetails);
        yield state.copyWith(formStatus: SubmissionSuccess());
      } on Exception catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(error: e.toString()));
      }
    } else if (event is ProfileEditDataChanged) {
      print(event.someDataChanged);
      yield state.copyWith(someDataChanged: event.someDataChanged);
    }
  }

  Future<ProfileSettingState> _mapProfileEditToState(
    ProfileSettingEdit event,
    ProfileSettingState state,
  ) async {
    final profileEdit = state.copyWith(
      firstName: event.user!.firstName,
      lastName: event.user!.lastName,
      email: event.user!.email,
    );
    return profileEdit;
  }
}

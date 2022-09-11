import 'dart:async';

import 'package:dream_app_bloc/data/user/user.dart';
import 'package:dream_app_bloc/repositories/user_repository.dart';
import 'package:dream_app_bloc/utils/form_submission_status.dart';
import 'package:dream_app_bloc/utils/shared_pref.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_setting_event.dart';
part 'profile_setting_state.dart';

class ProfileSettingBloc
    extends Bloc<ProfileSettingEvent, ProfileSettingState> {
  ProfileSettingBloc({required this.userRepository})
      : super(ProfileSettingInitial());

  final UserRepository userRepository;
  final _sharedPref = SharedPref();

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
      yield state.copyWith(someDataChanged: event.someDataChanged);
    } else if (event is IsDailyEnabledChange) {
      _sharedPref.saveBool(key: "Enable", value: event.isDailyEnabled);
      yield state.copyWith(isDailyEnabled: event.isDailyEnabled);
    } else if (event is ProfileTimeOfDayChanged) {
      yield state.copyWith(timeOfDay: event.timeOfDay);
    }
  }

  Future<ProfileSettingState> _mapProfileEditToState(
    ProfileSettingEdit event,
    ProfileSettingState state,
  ) async {
    bool isNotEmpty = false;
    final isEnabled = await _sharedPref.readBool("Enable");
    List<String> todd = [];
    final tod = await _sharedPref.readStr("timeOfDay");
    if (tod != null && isEnabled == true) {
      isNotEmpty = true;
      todd = tod.split(":");
    }

    final profileEdit = state.copyWith(
      firstName: event.user!.firstName,
      lastName: event.user!.lastName,
      email: event.user!.email,
      isDailyEnabled: isEnabled,
      timeOfDay: isNotEmpty
          ? TimeOfDay(
              hour: int.parse(todd[0]),
              minute: int.parse(todd[1].replaceAll(" AM", "")),
            )
          : null,
    );
    return profileEdit;
  }
}

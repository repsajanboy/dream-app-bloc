import 'dart:async';

import 'package:dream_app_bloc/repositories/auth_repository.dart';
import 'package:dream_app_bloc/utils/form_submission_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthorizationRepository authorizationRepository;
  RegisterBloc({required this.authorizationRepository})
      : super(RegisterState());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterFirstNameChanged) {
      yield state.copyWith(firstName: event.firstName);
    } else if (event is RegisterLastNameChanged) {
      yield state.copyWith(lastName: event.lastName);
    } else if (event is RegisterEmailChanged) {
      yield state.copyWith(email: event.email);
    } else if (event is RegisterPasswordChanged) {
      yield state.copyWith(password: event.password);
    } else if (event is RegisterSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        await authorizationRepository.register(
          state.firstName,
          state.lastName,
          state.email,
          state.password,
        );
        yield state.copyWith(formStatus: SubmissionSuccess());
      } on Exception catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(error: e.toString()));
      }
    } else if (event is RegisterObscureTextChanged) {
      yield state.copyWith(isObscureText: event.isObscureText);
    }
  }
}

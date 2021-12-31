import 'package:bloc/bloc.dart';
import 'package:dream_app_bloc/repositories/auth_repository.dart';
import 'package:dream_app_bloc/utils/form_submission_status.dart';
import 'package:dream_app_bloc/utils/shared_pref.dart';
import 'package:flutter/cupertino.dart';

part 'new_password_event.dart';
part 'new_password_state.dart';

class NewPasswordBloc extends Bloc<NewPasswordEvent, NewPasswordState> {
  final AuthorizationRepository authorizationRepository;
  final _sharedPref = SharedPref();
  NewPasswordBloc({required this.authorizationRepository})
      : super(NewPasswordState());

  @override
  Stream<NewPasswordState> mapEventToState(
    NewPasswordEvent event,
  ) async* {
    if (event is NewPasswordChanged) {
      yield state.copyWith(newPassword: event.newPassword);
    } else if (event is ConfirmPasswordChanged) {
      yield state.copyWith(confirmPassword: event.confirmPassword);
    } else if (event is NewPasswordSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        String? email = await _sharedPref.readStr("emailPass");
        email = email!.replaceAll('"', '').trim();
        await authorizationRepository.updatePassword(email, state.newPassword);
        yield state.copyWith(formStatus: SubmissionSuccess());
      } on Exception catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(error: e.toString()));
      }
    }
  }
}

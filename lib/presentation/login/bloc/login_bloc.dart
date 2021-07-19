import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dream_app_bloc/repositories/auth_repository.dart';
import 'package:dream_app_bloc/utils/form_submission_status.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final AuthorizationRepository authorizationRepository;

  LoginBloc({this.authorizationRepository}) : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
     if (event is LoginEmailChanged) {
      yield state.copyWith(email: event.email);
    } else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);
    } else if (event is LoginSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      final result = await authorizationRepository.login(state.email, state.password);
      if(result["token"] != null) {
        
        yield state.copyWith(formStatus: SubmissionSuccess());
      }
      else {
        yield state.copyWith(formStatus: SubmissionFailed(error: result["msg"].toString()));
      }
    }
  }
}

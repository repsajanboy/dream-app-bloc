import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dream_app_bloc/repositories/auth_repository.dart';
import 'package:dream_app_bloc/utils/form_submission_status.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthorizationRepository authorizationRepository;
  RegisterBloc({required this.authorizationRepository}) : super(RegisterState());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if(event is RegisterFirstNameChanged){
      yield state.copyWith(firstName: event.firstName);
    } else if(event is RegisterLastNameChanged){
      yield state.copyWith(lastName: event.lastName);
    } else if(event is RegisterEmailChanged){
      yield state.copyWith(email: event.email);
    } else if(event is RegisterPasswordChanged){
      yield state.copyWith(password: event.password);
    } else if(event is RegisterSubmitted){
      yield state.copyWith(formStatus: FormSubmitting());

      final result = await authorizationRepository.register(state.firstName, state.lastName, state.email, state.password);

      if(result["token"] != null) {
        
        yield state.copyWith(formStatus: SubmissionSuccess());
      }
      else {
        yield state.copyWith(formStatus: SubmissionFailed(error: result["msg"].toString()));
      }
    }
  }
}

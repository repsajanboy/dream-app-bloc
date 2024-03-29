// ignore_for_file: avoid_dynamic_calls

import 'dart:async';

import 'package:dream_app_bloc/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required AuthorizationRepository authorizationRepository})
      : assert(true),
      _authorizationRepository = authorizationRepository,
        super(AuthenticationInitial());


  final AuthorizationRepository _authorizationRepository;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool hasUser = await _authorizationRepository.checkUser();
      if(hasUser){
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    } else if (event is LogOut) {
        yield AuthenticationLoading();
      final logout = await _authorizationRepository.logout();
      if(logout["success"] == true) {
        yield AuthenticationUnauthenticated();
      }
    }
  }
}

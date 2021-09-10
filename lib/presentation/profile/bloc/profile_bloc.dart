import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dream_app_bloc/data/user/user.dart';
import 'package:dream_app_bloc/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required this.userRepository}) : super(ProfileInitial());
  final UserRepository userRepository;
  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is ProfileFetched) {
      yield await _profileFetchedToState(state);
    }
  }

  Future<ProfileState> _profileFetchedToState(ProfileState state) async {
    try {

      final details = await userRepository.getUserDetails();
      return ProfileFetchedSuccess(user: details);
    } on Exception {
      return ProfileFetchedError();
    }
  }
}
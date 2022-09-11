part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class ProfileFetched extends ProfileEvent {
  const ProfileFetched();

  @override
  List<Object> get props => [];
}

part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileFetchedLoaded extends ProfileState {
  final User user;

  const ProfileFetchedLoaded({required this.user});

  @override
  List<Object> get props => [user];
}

class ProfileFetchedError extends ProfileState {}
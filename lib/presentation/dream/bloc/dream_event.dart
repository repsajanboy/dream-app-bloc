part of 'dream_bloc.dart';

@immutable
abstract class DreamEvent extends Equatable {
  const DreamEvent();
}

class DreamsFetched extends DreamEvent {
  const DreamsFetched();

  @override
  List<Object> get props => [];
}

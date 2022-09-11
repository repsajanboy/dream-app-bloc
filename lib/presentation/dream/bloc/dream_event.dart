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

class DreamDelete extends DreamEvent {
  final String dreamId;

  const DreamDelete({required this.dreamId});

   @override
  List<Object> get props => [];
}

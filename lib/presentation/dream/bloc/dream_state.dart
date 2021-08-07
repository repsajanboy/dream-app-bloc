part of 'dream_bloc.dart';

enum DreamStatus { initial, success, error }

class DreamState extends Equatable {
  final DreamStatus status;
  final List<Dream> dreams;

  const DreamState({
    this.status = DreamStatus.initial,
    this.dreams = const <Dream>[],
  });

  DreamState copyWith({DreamStatus? status, List<Dream>? dreams}) {
    return DreamState(
      status: status ?? this.status,
      dreams: dreams ?? this.dreams,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, posts: ${dreams.length} }''';
  }

  @override
  List<Object> get props => [status, dreams];
}

class DreamInitial extends DreamState {}

part of 'favorite_dream_bloc.dart';

enum FavoriteDreamStatus { initial, success, error }

class FavoriteDreamState extends Equatable {
  final FavoriteDreamStatus status;
  final List<Dream> dreams;

  const FavoriteDreamState({
    this.status = FavoriteDreamStatus.initial,
    this.dreams = const <Dream>[],
  });

  FavoriteDreamState copyWith({
    FavoriteDreamStatus? status,
    List<Dream>? dreams,
  }) {
    return FavoriteDreamState(
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

class FavoriteDreamInitial extends FavoriteDreamState {}

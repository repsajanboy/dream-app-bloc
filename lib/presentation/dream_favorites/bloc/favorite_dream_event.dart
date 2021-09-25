part of 'favorite_dream_bloc.dart';

@immutable
abstract class FavoriteDreamEvent {}

class FavoriteDreamsFetched extends FavoriteDreamEvent {
  FavoriteDreamsFetched();
}

class FavoriteDreamChanged extends FavoriteDreamEvent {
  final bool? favorite;
  final String? id;

  FavoriteDreamChanged({this.favorite, this.id});
}

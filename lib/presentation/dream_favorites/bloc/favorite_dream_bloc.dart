import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dream_app_bloc/data/dream/dream.dart';
import 'package:dream_app_bloc/repositories/dream_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'favorite_dream_event.dart';
part 'favorite_dream_state.dart';

class FavoriteDreamBloc extends Bloc<FavoriteDreamEvent, FavoriteDreamState> {
  final DreamRepository dreamRepository;
  FavoriteDreamBloc({required this.dreamRepository})
      : super(FavoriteDreamInitial());

  @override
  Stream<FavoriteDreamState> mapEventToState(
    FavoriteDreamEvent event,
  ) async* {
    if (event is FavoriteDreamsFetched) {
      yield await _mapFavoriteDreamsFetchedToState(state);
    } else if (event is FavoriteDreamChanged) {
      try {
        final updateFavorite = {
          "favorite": event.favorite,
          "updateDate": DateTime.now().toIso8601String(),
        };

        await dreamRepository.updateFavoriteDream(event.id!, updateFavorite);
        final dreams = await dreamRepository.fetchFavoriteDreams();
        yield state.copyWith(
          status: FavoriteDreamStatus.success,
          dreams: dreams,
        );
      } on Exception {
        yield state.copyWith(status: FavoriteDreamStatus.error);
      }
    }
  }

  Future<FavoriteDreamState> _mapFavoriteDreamsFetchedToState(
      FavoriteDreamState state) async {
    try {
      if (state.status == FavoriteDreamStatus.initial) {
        final dreams = await dreamRepository.fetchFavoriteDreams();
        return state.copyWith(
          status: FavoriteDreamStatus.success,
          dreams: dreams,
        );
      }
      final dreams = await dreamRepository.fetchFavoriteDreams();
      return state.copyWith(
        status: FavoriteDreamStatus.success,
        dreams: dreams,
      );
    } on Exception {
      return state.copyWith(status: FavoriteDreamStatus.error);
    }
  }
}

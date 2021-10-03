import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dream_app_bloc/data/dream/dream.dart';
import 'package:dream_app_bloc/repositories/dream_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'dream_event.dart';
part 'dream_state.dart';

class DreamBloc extends Bloc<DreamEvent, DreamState> {
  final DreamRepository dreamRepository;
  DreamBloc({required this.dreamRepository}) : super(DreamInitial());

  @override
  Stream<DreamState> mapEventToState(
    DreamEvent event,
  ) async* {
    if (event is DreamsFetched) {
      yield await _mapDreamsFetchedToState(state);
    } else if (event is DreamDelete) {
      try {
        await dreamRepository.deleteDream(event.dreamId);
        Future.delayed(const Duration(milliseconds: 200));
        final dreams = await dreamRepository.fetchDreams();
        yield state.copyWith(
          status: DreamStatus.success,
          dreams: dreams,
        );
      } on Exception {
        yield state.copyWith(status: DreamStatus.error);
      }
    }
  }

  Future<DreamState> _mapDreamsFetchedToState(DreamState state) async {
    try {
      if (state.status == DreamStatus.initial) {
        final dreams = await dreamRepository.fetchDreams();
        return state.copyWith(
          status: DreamStatus.success,
          dreams: dreams,
        );
      }
      final dreams = await dreamRepository.fetchDreams();
      return state.copyWith(
        status: DreamStatus.success,
        dreams: dreams,
      );
    } on Exception {
      return state.copyWith(status: DreamStatus.error);
    }
  }
}

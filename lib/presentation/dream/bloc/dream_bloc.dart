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
    if(event is DreamsFetched){
      yield await _mapDreamsFetchedToState(state);
    }
  }

  Future<DreamState> _mapDreamsFetchedToState(DreamState state) async {
    try {
    if (state.status == DreamStatus.initial) {
      // final dreams = await _fetchPosts();
      // return state.copyWith(
      //   status: DreamStatus.success,
      //   dreams: dreams,
      // );
    }
    // final posts = await _fetchPosts(state.posts.length);
    // return posts.isEmpty
    //     ? state.copyWith(hasReachedMax: true)
    //     : state.copyWith(
    //         status: PostStatus.success,
    //         posts: List.of(state.posts)..addAll(posts),
    //         hasReachedMax: false,
    //       );
  } on Exception {
    //return state.copyWith(status: PostStatus.failure);
  }
}
}

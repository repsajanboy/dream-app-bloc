import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dream_app_bloc/data/dream/dream.dart';
import 'package:dream_app_bloc/data/dream/post_dream.dart';
import 'package:dream_app_bloc/repositories/dream_repository.dart';
import 'package:dream_app_bloc/utils/form_submission_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'upsert_dream_event.dart';
part 'upsert_dream_state.dart';

class UpsertDreamBloc extends Bloc<UpsertDreamEvent, UpsertDreamState> {
  final DreamRepository dreamRepository;
  UpsertDreamBloc({required this.dreamRepository}) : super(UpsertDreamState());

  @override
  Stream<UpsertDreamState> mapEventToState(
    UpsertDreamEvent event,
  ) async* {
    if (event is UpsertInputDateChanged) {
      yield state.copyWith(inputDate: event.inputDate);
    } else if (event is UpsertContentChanged) {
      yield state.copyWith(content: event.content);
    } else if (event is UpsertTitleChanged) {
      yield state.copyWith(title: event.title);
    } else if (event is UpsertCategoryChanged) {
      yield state.copyWith(category: event.category);
    } else if (event is UpsertRateChanged) {
      yield state.copyWith(rate: event.rate);
    } else if (event is UpsertSaved) {
      yield state.copyWith(formStatus: FormSubmitting());
      final postDream = PostDream(
          title: state.title,
          content: state.content,
          category: state.category,
          rate: state.rate,
          inputDate: state.inputDate);
      try {
        await dreamRepository.postDream(postDream);

        yield state.copyWith(formStatus: SubmissionSuccess());
      } on Exception catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(error: e.toString()));
      }
    } else if (event is UpsertEditSaved) {
      yield state.copyWith(formStatus: FormSubmitting());
      final updateDream = PostDream(
          id: state.id,
          title: state.title,
          content: state.content,
          category: state.category,
          rate: state.rate,
          inputDate: state.inputDate,
          updateDate: DateTime.now());
      try {
        await dreamRepository.updateDream(updateDream);

        yield state.copyWith(formStatus: SubmissionSuccess());
      } on Exception catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(error: e.toString()));
      }
    } else if (event is UpsertPageViewIndexChanged) {
      yield state.copyWith(pageViewIndex: event.pageViewIndex);
    } else if (event is UpsertCategoriesIndexChanged) {
      yield state.copyWith(categoriesIndex: event.categoriesIndex);
    } else if (event is UpsertToEdit) {
      final editState = UpsertDreamState(
        id: event.postDream.id,
        title: event.postDream.title,
        content: event.postDream.content,
        inputDate: event.postDream.inputDate,
        category: event.postDream.category,
        //rate: event.postDream.rate,
      );
      yield editState;
    }
  }
}

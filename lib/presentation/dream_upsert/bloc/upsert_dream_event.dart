part of 'upsert_dream_bloc.dart';

@immutable
abstract class UpsertDreamEvent {}

class UpsertInputDateChanged extends UpsertDreamEvent {
  final DateTime? inputDate;

  UpsertInputDateChanged({required this.inputDate});
}

class UpsertContentChanged extends UpsertDreamEvent {
  final String? content;

  UpsertContentChanged({this.content});
}

class UpsertTitleChanged extends UpsertDreamEvent {
  final String? title;

  UpsertTitleChanged({this.title});
}

class UpsertCategoryChanged extends UpsertDreamEvent {
  final String? category;

  UpsertCategoryChanged({this.category});
}

class UpsertRateChanged extends UpsertDreamEvent {
  final int? rate;

  UpsertRateChanged({this.rate});
}

class UpsertPageViewIndexChanged extends UpsertDreamEvent {
  final int? pageViewIndex;

  UpsertPageViewIndexChanged({this.pageViewIndex});
}

class UpsertSaved extends UpsertDreamEvent {}

class UpsertEditSaved extends UpsertDreamEvent {}

class UpsertToEdit extends UpsertDreamEvent {
  final Dream postDream;

  UpsertToEdit({required this.postDream});
}

part of 'upsert_dream_bloc.dart';

class UpsertDreamState extends Equatable {
  final String id;
  final DateTime inputDate;
  final String content;
  final String title;
  final String category;
  final int rate;
  final bool favorite;
  final FormSubmissionStatus formStatus;
  final int pageViewIndex;

  UpsertDreamState({
    this.id = '',
    DateTime? inputDate,
    this.content = '',
    this.title = '',
    this.category = '',
    this.rate = 3,
    this.favorite = false,
    this.formStatus = const InitialFormStatus(),
    this.pageViewIndex = 0,
  }) : inputDate = inputDate ?? DateTime.now();

  UpsertDreamState copyWith({
    String? id,
    DateTime? inputDate,
    String? content,
    String? title,
    String? category,
    int? rate,
    bool? favorite,
    FormSubmissionStatus? formStatus,
    int? pageViewIndex,
  }) {
    return UpsertDreamState(
        id: id ?? this.id,
        inputDate: inputDate ?? this.inputDate,
        content: content ?? this.content,
        title: title ?? this.title,
        category: category ?? this.category,
        rate: rate ?? this.rate,
        favorite: favorite ?? this.favorite,
        formStatus: formStatus ?? this.formStatus,
        pageViewIndex: pageViewIndex ?? this.pageViewIndex,
        );
  }

  @override
  List<Object> get props => [id, inputDate, content, title, category, rate, favorite, formStatus, pageViewIndex];

  @override
  String toString() {
    return 'Todo { id: $id }';
  }
}

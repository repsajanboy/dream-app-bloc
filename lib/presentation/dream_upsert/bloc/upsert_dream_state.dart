part of 'upsert_dream_bloc.dart';

class UpsertDreamState extends Equatable {
  final String id;
  final DateTime inputDate;
  final String content;
  final String title;
  final String category;
  final int rate;
  final FormSubmissionStatus formStatus;
  final int pageViewIndex;
  final int? categoriesIndex;

  UpsertDreamState({
    this.id = '',
    DateTime? inputDate,
    this.content = '',
    this.title = '',
    this.category = '',
    this.rate = 1,
    this.formStatus = const InitialFormStatus(),
    this.pageViewIndex = 0,
    this.categoriesIndex,
  }) : inputDate = inputDate ?? DateTime.now();

  UpsertDreamState copyWith({
    String? id,
    DateTime? inputDate,
    String? content,
    String? title,
    String? category,
    int? rate,
    FormSubmissionStatus? formStatus,
    int? pageViewIndex,
    int? categoriesIndex,
  }) {
    return UpsertDreamState(
        id: id ?? this.id,
        inputDate: inputDate ?? this.inputDate,
        content: content ?? this.content,
        title: title ?? this.title,
        category: category ?? this.category,
        rate: rate ?? this.rate,
        formStatus: formStatus ?? this.formStatus,
        pageViewIndex: pageViewIndex ?? this.pageViewIndex,
        categoriesIndex: categoriesIndex ?? this.categoriesIndex);
  }

  @override
  List<Object> get props => [id, inputDate, content, title, category, rate, formStatus, pageViewIndex];

  @override
  String toString() {
    return 'Todo { id: $id }';
  }
}

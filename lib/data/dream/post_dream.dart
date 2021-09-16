class PostDream {
  PostDream({
    this.id,
    this.title,
    this.content,
    this.category,
    this.rate,
    this.inputDate,
    this.updateDate,
  });
  String? id;
  String? title;
  String? content;
  String? category;
  int? rate;
  DateTime? inputDate;
  DateTime? updateDate;

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "category": category,
        "rate": rate,
        "inputDate": inputDate!.toIso8601String(),
        "updateDate": updateDate == null ? null : updateDate!.toIso8601String(),
      };
}

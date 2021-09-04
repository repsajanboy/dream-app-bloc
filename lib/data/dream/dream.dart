
class Dream {
    Dream({
        required this.id,
        required this.title,
        required this.content,
        required this.category,
        required this.rate,
        required this.user,
        required this.inputDate,
    });

    String id;
    String title;
    String content;
    String category;
    int rate;
    String user;
    DateTime inputDate;

    factory Dream.fromJson(Map<String, dynamic> json) => Dream(
        id: json["id"] as String,
        title: json["title"] as String,
        content: json["content"] as String,
        category: json["category"] as String,
        rate: json["rate"] as int,
        user: json["user"] as String,
        inputDate: DateTime.parse(json["inputDate"].toString()),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "content": content,
        "category": category,
        "rate": rate,
        "user": user,
        "inputDate": inputDate.toIso8601String(),
    };
}

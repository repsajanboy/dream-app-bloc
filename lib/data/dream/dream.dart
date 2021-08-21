
class Dream {
    Dream({
        required this.id,
        required this.title,
        required this.content,
        required this.category,
        required this.rate,
        required this.user,
        required this.createDate,
    });

    String id;
    String title;
    String content;
    String category;
    int rate;
    String user;
    DateTime createDate;

    factory Dream.fromJson(Map<String, dynamic> json) => Dream(
        id: json["id"] as String,
        title: json["title"] as String,
        content: json["content"] as String,
        category: json["category"] as String,
        rate: json["rate"] as int,
        user: json["user"] as String,
        createDate: DateTime.parse(json["createDate"].toString()),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "content": content,
        "category": category,
        "rate": rate,
        "user": user,
        "createDate": createDate.toIso8601String(),
    };
}

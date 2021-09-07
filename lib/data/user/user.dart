
class User {
    User({
        required this.email,
        required this.createDate,
        required this.updateDate,
        required this.firstName,
        required this.lastName,
    });

    String email;
    DateTime createDate;
    DateTime updateDate;
    String firstName;
    String lastName;

    factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"] as String,
        createDate: DateTime.parse(json["createDate"].toString()),
        updateDate: DateTime.parse(json["updateDate"].toString()),
        firstName: json["firstName"] as String,
        lastName: json["lastName"] as String,
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "createDate": createDate.toIso8601String(),
        "updateDate": updateDate.toIso8601String(),
        "firstName": firstName,
        "lastName": lastName,
    };
}

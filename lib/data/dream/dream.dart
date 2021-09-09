import 'package:json_annotation/json_annotation.dart';

part 'dream.g.dart';

@JsonSerializable(includeIfNull: true)
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

  factory Dream.fromJson(Map<String, dynamic> json) => _$DreamFromJson(json);
  Map<String, dynamic> toJson() => _$DreamToJson(this);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dream.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dream _$DreamFromJson(Map<String, dynamic> json) {
  return Dream(
    id: json['id'] as String,
    title: json['title'] as String,
    content: json['content'] as String,
    category: json['category'] as String,
    rate: json['rate'] as int,
    favorite: json['favorite'] as bool,
    user: json['user'] as String,
    inputDate: DateTime.parse(json['inputDate'] as String),
  );
}

Map<String, dynamic> _$DreamToJson(Dream instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'category': instance.category,
      'rate': instance.rate,
      'favorite': instance.favorite,
      'user': instance.user,
      'inputDate': instance.inputDate.toIso8601String(),
    };

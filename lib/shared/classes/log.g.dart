// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Log _$LogFromJson(Map<String, dynamic> json) => Log(
      id: json['id'] as int,
      title: json['title'] as String,
      text: json['text'] as String,
      created_at: DateTime.parse(json['created_at'] as String),
      mental: json['mental'] as double,
      physical: json['physical'] as double,
      social: json['social'] as double,
      professional: json['professional'] as double,
    );

Map<String, dynamic> _$LogToJson(Log instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'text': instance.text,
      'created_at': instance.created_at.toIso8601String(),
      'mental': instance.mental,
      'physical': instance.physical,
      'social': instance.social,
      'professional': instance.professional,
    };

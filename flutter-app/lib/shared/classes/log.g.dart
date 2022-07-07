// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Log _$LogFromJson(Map<String, dynamic> json) => Log(
      id: json['id'] as int?,
      title: json['title'] as String,
      text: json['text'] as String,
      created_at: DateTime.parse(json['created_at'] as String),
      completed_at: json['completed_at'] == null
          ? null
          : DateTime.parse(json['completed_at'] as String),
      mental: (json['mental'] as num).toDouble(),
      physical: (json['physical'] as num).toDouble(),
      social: (json['social'] as num).toDouble(),
      professional: (json['professional'] as num).toDouble(),
    );

Map<String, dynamic> _$LogToJson(Log instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'text': instance.text,
      'created_at': instance.created_at.toIso8601String(),
      'completed_at': instance.completed_at?.toIso8601String(),
      'mental': instance.mental,
      'physical': instance.physical,
      'social': instance.social,
      'professional': instance.professional,
    };

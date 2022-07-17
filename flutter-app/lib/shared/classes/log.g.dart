// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Log _$LogFromJson(Map<String, dynamic> json) => Log(
      id: json['id'] as String?,
      title: json['title'] as String,
      text: json['text'] as String,
      created_at: DateTime.parse(json['created_at'] as String),
      isMemorable: json['isMemorable'] as bool,
      lat: (json['lat'] as num?)?.toDouble(),
      long: (json['long'] as num?)?.toDouble(),
      mental: json['mental'] as int,
      physical: json['physical'] as int,
      social: json['social'] as int,
      professional: json['professional'] as int,
    );

Map<String, dynamic> _$LogToJson(Log instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'text': instance.text,
      'created_at': instance.created_at.toIso8601String(),
      'isMemorable': instance.isMemorable,
      'lat': instance.lat,
      'long': instance.long,
      'mental': instance.mental,
      'physical': instance.physical,
      'social': instance.social,
      'professional': instance.professional,
    };

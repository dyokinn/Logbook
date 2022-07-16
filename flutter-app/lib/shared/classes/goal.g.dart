// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Goal _$GoalFromJson(Map<String, dynamic> json) => Goal(
      id: json['id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String,
      created_at: DateTime.parse(json['created_at'] as String),
      isComplete: json['isComplete'] as bool,
      completed_at: json['completed_at'] == null
          ? null
          : DateTime.parse(json['completed_at'] as String),
      steps: (json['steps'] as List<dynamic>?)
              ?.map((e) => GoalStep.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$GoalToJson(Goal instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'created_at': instance.created_at.toIso8601String(),
      'isComplete': instance.isComplete,
      'completed_at': instance.completed_at?.toIso8601String(),
      'steps': instance.steps.map((e) => e.toJson()).toList(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_step.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoalStep _$GoalStepFromJson(Map<String, dynamic> json) => GoalStep(
      text: json['text'] as String,
      isComplete: json['isComplete'] as bool,
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$GoalStepToJson(GoalStep instance) => <String, dynamic>{
      'text': instance.text,
      'isComplete': instance.isComplete,
      'completedAt': instance.completedAt?.toIso8601String(),
    };

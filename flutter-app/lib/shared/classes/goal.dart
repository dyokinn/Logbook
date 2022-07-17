import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logbook/shared/classes/goal_step.dart';

part'goal.g.dart';


@JsonSerializable(explicitToJson: true)

class Goal {
  String? id;
  String name;
  String description;
  DateTime created_at;
  bool isComplete;
  DateTime? completed_at;
  List<GoalStep> steps;

  Goal({
    this.id,
    required this.name,
    required this.description,
    required this.created_at,
    required this.isComplete,
    this.completed_at,
    this.steps = const []
  });

  factory Goal.fromJson(Map<String, dynamic> data) => _$GoalFromJson(data);

  Map<String, dynamic> toJson() => _$GoalToJson(this);
}